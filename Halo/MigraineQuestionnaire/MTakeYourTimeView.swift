//
//  MTakeYourTime.swift
//  Halo
//
//  Created by Gdwn16 on 05/05/2026.
//

import SwiftUI

struct MTakeYourTimeView: View {
    
    let tappedButton : () -> Void
    
    var body: some View {
        ZStack {
            Color.clear.noiseBackground()
            VStack(alignment: .center, spacing: 32) {
                Image("infoIcon")
                    .resizeImageTo(40)
                
                VStack (spacing: 16) {
                    HaloText(text: "Take your time", style: .headingLg)
                    
                    HaloText(text: "Migraine hangovers are real. You can skip any of these fields and come back to them when you feel much better.", style: .bodyLg, color: HaloColor.textSubtle)
                }
                
                MainButton(state: .secondary, label: "Okay", fillContainer: true) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        tappedButton()
                    }
                }
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.horizontal, Padding.mgnMobile)
        }
    }
}

#Preview {
        MTakeYourTimeView(){}
}
