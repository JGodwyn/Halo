//
//  OnboardingView.swift
//  Halo
//
//  Created by Gdwn16 on 24/02/2026.
//

import SwiftUI

struct AuthView: View {
    
    @Environment(AuthManager.self) var auth
    @State private var isButtonLoading : Bool = false
    
    var body: some View {
        ZStack {
            Color.clear.noiseBackground()
            
            VStack(alignment: .center, spacing: 32) {
                Image("FullLogo")
                    .resizeImageTo(120)
                
                
                Image("BrainIllustration")
                    .resizeImageTo(320)
                    .padding(.vertical, -80)
                
                VStack(spacing: Distance.distXl) {
                    VStack {
                        HaloText(text: "Track migraines", style: .headingMd)
                        HaloText(text: "Find what helps", style: .headingMd)
                    }
                    
                    HaloText(text: "A simple diary to log your migraines. Track patterns, identify possible triggers, and see what's working.", color: HaloColor.textSubtle)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(spacing: 16) {
                        MainButton(label: "Sign In With Google", image: "GoogleLogo", fillContainer: true) {
                            Task {
                                await auth.signInWithGoogle()
                            }
                        }
                        
                        MainButton(label: "Sign In With Apple", image: "AppleLogo", fillContainer: true){}
                    }
                }
                
                HStack {
                    Image("infoIcon")
                        .resizeImageTo(16)
                    
                    HaloText(text: "This is not medical advice", style: .bodyMd, color: HaloColor.textSubtle)
                }
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(Padding.mgnMobile)
        }
    }
}

#Preview {
    AuthView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
}
