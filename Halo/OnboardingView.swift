//
//  OnboardingView.swift
//  Halo
//
//  Created by Gdwn16 on 24/02/2026.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            Color.clear.noiseBackground()
            VStack(alignment: .leading) {
                Text("Hello, World!")
                    .foregroundStyle(HaloColor.textBold)
                    .fontStyle(.bodyLg)
                
                Group {
                    Text("Track migraines.")
                    Text("Find what helps.")
                }
                .foregroundStyle(HaloColor.textBold)
                .fontStyle(.headingMd)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(Padding.mgnMobile)
        }
    }
}

#Preview {
    OnboardingView()
}
