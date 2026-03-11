//
//  MConfirmationView.swift
//  Halo
//
//  Created by Gdwn16 on 10/03/2026.
//

import SwiftUI

struct MConfirmationView: View {
    
    let header : String
    let description : String
    let tappedButton : () -> Void
    
    var body: some View {
        ZStack {
            Color.clear.noiseBackground()
            VStack(alignment: .center, spacing: 32) {
                Image("ThumbsUp")
                    .resizeImageTo(320)
                    .padding(.vertical, -40)
                
                VStack (spacing: 16) {
                    HaloText(text: header, style: .headingLg)
                    
                    HaloText(text: description, style: .bodyLg, color: HaloColor.textSubtle)
                }
                    
                    MainButton(state: .secondary, label: "Okay", fillContainer: true) {
                        tappedButton()
                    }
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.horizontal, Padding.mgnMobile)
        }
    }
}

#Preview {
    MConfirmationView(header: "Got it", description: "We’ve saved your log. You’ll get a reminder in 30 minutes to see how you’re feeling.") {}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
