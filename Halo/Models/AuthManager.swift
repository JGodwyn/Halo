//
//  AuthManager.swift
//  Halo
//
//  Created by Gdwn16 on 25/02/2026.
//

import Foundation
import SwiftUI
import GoogleSignIn
import Supabase

struct Profile: Codable {
    let id: UUID
    var fullName: String?
    var dateOfBirth: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case dateOfBirth = "date_of_birth"
    }

    // Custom decoder to handle Supabase's plain date format "yyyy-MM-dd"
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        fullName = try container.decodeIfPresent(String.self, forKey: .fullName)

        if let dobString = try container.decodeIfPresent(String.self, forKey: .dateOfBirth) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(identifier: "UTC")
            dateOfBirth = formatter.date(from: dobString)
        } else {
            dateOfBirth = nil
        }
    }

    // Standard memberwise init for encoding (upsert)
    init(id: UUID, fullName: String?, dateOfBirth: Date?) {
        self.id = id
        self.fullName = fullName
        self.dateOfBirth = dateOfBirth
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(fullName, forKey: .fullName)

        if let dob = dateOfBirth {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(identifier: "UTC")
            try container.encode(formatter.string(from: dob), forKey: .dateOfBirth)
        }
    }
}


enum AuthStatus : String {
    case loggedIn
    case loggedOut
    case onboarding
}

@Observable
final class AuthManager {

    // Persisted so the app remembers state across restarts
    @ObservationIgnored
    @AppStorage("loginStatus") private(set) var _loginStatus: String = AuthStatus.loggedOut.rawValue
    var loginStatus: AuthStatus {
        get {
            access(keyPath: \.loginStatus)
            return AuthStatus(rawValue: _loginStatus) ?? .loggedOut
        }
        set {
            withMutation(keyPath: \.loginStatus) {
                _loginStatus = newValue.rawValue
            }
        }
    }
    
    @ObservationIgnored
    @AppStorage("userName") private(set) var _userName: String = ""
    var userName: String? {
        get {
            access(keyPath: \.userName)
            return _userName.isEmpty ? nil : _userName
        }
        set {
            withMutation(keyPath: \.userName) {
                _userName = newValue ?? ""
            }
        }
    }

    @ObservationIgnored
    @AppStorage("dateOfBirth") private(set) var _dateOfBirth: Double = 0
    var dateOfBirth: Date? {
        get {
            access(keyPath: \.dateOfBirth)
            return _dateOfBirth == 0 ? nil : Date(timeIntervalSince1970: _dateOfBirth)
        }
        set {
            withMutation(keyPath: \.dateOfBirth) {
                _dateOfBirth = newValue?.timeIntervalSince1970 ?? 0
            }
        }
    }
    
    
    var errorMessage: String? = nil

    // MARK: - Google Sign In

    @MainActor
    func signInWithGoogle() async {
        guard let rootViewController = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows.first?.rootViewController
        else { return }

        do {
            let rawNonce = randomNonceString()
            let hashedNonce = sha256Hash(of: rawNonce)

            let result = try await GIDSignIn.sharedInstance.signIn(
                withPresenting: rootViewController,
                hint: nil,
                additionalScopes: [],
                nonce: hashedNonce
            )

            guard let idToken = result.user.idToken?.tokenString else { return }
            let accessToken = result.user.accessToken.tokenString

            userName = result.user.profile?.name

            try await supabase.auth.signInWithIdToken(
                credentials: .init(
                    provider: .google,
                    idToken: idToken,
                    accessToken: accessToken,
                    nonce: rawNonce
                )
            )

            await checkProfile()

        } catch {
            errorMessage = error.localizedDescription
            print("Sign-in error: \(error)")
        }
    }

    // MARK: - Profile

    func checkProfile() async {
        do {
            let profile: Profile = try await supabase
                .from("profiles")
                .select()
                .single()
                .execute()
                .value

            userName = profile.fullName
            dateOfBirth = profile.dateOfBirth

            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
                loginStatus = profile.dateOfBirth != nil ? .loggedIn : .onboarding
            }
        } catch {
            print("Error checking profile: \(error)")
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
                loginStatus = .onboarding
            }
        }
    }

    func saveProfile(dateOfBirth: Date) async {
        guard let userId = try? await supabase.auth.session.user.id else { return }

        do {
            let profile = Profile(
                id: userId,
                fullName: userName,
                dateOfBirth: dateOfBirth
            )

            try await supabase
                .from("profiles")
                .upsert(profile)
                .execute()

            self.dateOfBirth = dateOfBirth

            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
                loginStatus = .loggedIn
            }
        } catch {
            errorMessage = error.localizedDescription
            print("Error saving profile: \(error)")
        }
    }

    func fetchProfile() async {
        guard loginStatus != .loggedOut else { return }

        // Check if Supabase has a valid session first
        guard let _ = try? await supabase.auth.session else {
            // No valid session — clear everything
            await MainActor.run {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
                    loginStatus = .loggedOut
                    _userName = ""
                    _dateOfBirth = 0
                }
            }
            return
        }

        // Session is valid, proceed to fetch profile
        do {
            let profile: Profile = try await supabase
                .from("profiles")
                .select()
                .single()
                .execute()
                .value

            userName = profile.fullName
            dateOfBirth = profile.dateOfBirth

            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
                loginStatus = profile.dateOfBirth != nil ? .loggedIn : .onboarding
            }
        } catch {
            print("Error fetching profile: \(error)")
            if error is AuthError {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
                    loginStatus = .loggedOut
                    _userName = ""
                    _dateOfBirth = 0
                }
            }
        }
    }

    // MARK: - Session

    func logOut() {
        Task {
            try? await supabase.auth.signOut()
            GIDSignIn.sharedInstance.signOut()

            await MainActor.run {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
                    loginStatus = .loggedOut
                    self._userName = ""
                    self._dateOfBirth = 0
                }
            }
        }
    }
}


