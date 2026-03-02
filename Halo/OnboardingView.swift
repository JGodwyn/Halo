//
//  OnboardingView.swift
//  Halo
//
//  Created by Gdwn16 on 28/02/2026.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(AuthManager.self) var auth
    @State private var dob : Date = Date()
    @State private var userName : String = ""
    
    private var earliestBirthDate: Date {
        Calendar.current.date(byAdding: .year, value: -120, to: Date())!
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                
                VStack {
                    Text("Hi there, " + (auth.userName ?? "Debug name"))
                        .fontStyle(.titleLg, color: HaloColor.textSubtle)
                    
                    HaloText(text: "Just the following to complete your account", style: .headingSm)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 16) {
                    RoundTextField(boundTo: $userName)
                    
                    HStack {
                        HaloText(text: "Your date of birth", color: HaloColor.textSubtle)
                        
                        Spacer()
                        DatePicker(selection: $dob, in: earliestBirthDate...Date(), displayedComponents: .date) {
                            
                        }
                        .labelsHidden()
                    }
                    .padding(.trailing, 8)
                    .padding(.leading, 16)
                    .padding(.vertical, 8)
                    .background(HaloColor.surface1, in: RoundedRectangle(cornerRadius: .infinity))
                }
                
                MainButton(label: "Continue", fillContainer: true) {
                    Task {
                        await auth.saveProfile(username: userName, dateOfBirth: dob)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(Padding.mgnMobile)
        .frame(maxWidth: .infinity)
        .noiseBackground()
        .onAppear {
            userName = auth.userName ?? ""
        }
    }
}

#Preview {
    OnboardingView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
