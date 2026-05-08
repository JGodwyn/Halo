//
//  MTakeYourTimeRichView.swift
//  Halo
//
//  Created by Gdwn16 on 07/05/2026.
//

import SwiftUI

struct MTakeYourTimeRichView: View {
    
    let tappedButton : (_ type : actionType) -> Void
    
    enum actionType {
        case stopForNow
        case continueAnyway
    }
    
    var body: some View {
        ZStack {
            Color.clear.noiseBackground()
            VStack(alignment: .center, spacing: 32) {
                Image("EtherealFlame")
                    .resizeImageTo(320)
                
                VStack (spacing: 16) {
                    HaloText(text: "Take your time", style: .headingLg)
                    
                    HaloText(text: "Post-migraine hangovers are real. You can stop here and come back later if you want.", style: .bodyLg, color: HaloColor.textSubtle)
                }
                
                VStack (spacing: 16) {
                    MainButton(state: .primary, label: "Continue anyway", fillContainer: true) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            tappedButton(.continueAnyway)
                        }
                    }
                    
                    MainButton(state: .secondary, label: "Stop for now", fillContainer: true) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            tappedButton(.stopForNow)
                        }
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
    MTakeYourTimeRichView(){type in }
}
