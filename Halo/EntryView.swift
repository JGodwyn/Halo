//
//  EntryView.swift
//  Halo
//
//  Created by Gdwn16 on 26/02/2026.
//

import SwiftUI

struct EntryView: View {
    
    @Environment(AuthManager.self) var auth
    
    var body: some View {
        ZStack {
            switch auth.loginStatus {
            case .loggedIn :
                HomeView()
                    .transition(.opacity)
            case .loggedOut :
                AuthView()
                    .transition(.opacity)
            case .onboarding :
                OnboardingView()
                    .transition(.opacity)
            }
        }
        .noiseBackground() // just for the preview
        .task {
            await auth.fetchProfile()
        }
    }
}

#Preview {
    EntryView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
}
