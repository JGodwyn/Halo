//
//  ConnectHealthProviderView.swift
//  Halo
//
//  Created by Gdwn16 on 02/03/2026.
//

import SwiftUI

struct ConnectHealthProviderView: View {
    
    @Environment(AuthManager.self) var auth
    
    var body: some View {
        ZStack {
            
            Color.clear.noiseBackground()
            
            ScrollView {
                VStack(spacing: 24) {
                    Image("FullLogo")
                        .resizeImageTo(120)
                    
                    Image("ConnectedIllustation")
                        .resizeImageTo(320)
                        .padding(.vertical, -40)
                    
                    VStack (spacing: 16) {
                        HaloText(text: "You're set", style: .headingLg)
                        
                        HaloText(text: "Link your health app now or do it later. You don’t need it to use the app though.", style: .bodyLg, color: HaloColor.textSubtle)
                    }
                    
                    VStack (spacing: 16) {
                        MainButton(state: .secondary, label: "Connect Apple Health", image: "AppleHealth", fillContainer: true) {
                            
                        }
                        
                        MainButton(state: .secondary, label: "Connect Google Fit", image: "GoogleFit", fillContainer: true) {
                            
                        }
                        
                        MainButton(state: .secondary, label: "Continue Without Linking", fillContainer: true) {
                            auth.showConnectHealthModal(false)
                        }
                    }
                }
                .multilineTextAlignment(.center)
            }
            .padding(.horizontal, Padding.mgnMobile)
        }
    }
}

#Preview {
    ConnectHealthProviderView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
