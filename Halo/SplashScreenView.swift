//
//  SplashScreenView.swift
//  Halo
//
//  Created by Gdwn16 on 23/02/2026.
//

import SwiftUI

struct SplashScreenView: View {
    
    @Binding var showSplashScreen : Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .noiseBackground()
            Image("HaloLogo")
                .resizable()
                .frame(width: 200, height: 200)
        }
        .onAppear {
            Task {
                try await Task.sleep(for: .seconds(2))
                showSplashScreen = false
            }
        }
    }
}

#Preview {
    SplashScreenView(showSplashScreen: .constant(true))
}
