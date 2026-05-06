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
    let image : String
    let tappedButton : () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Image(image)
                .resizeImageTo(320)
                .padding(.vertical, -40)
            
            VStack (spacing: 16) {
                HaloText(text: header, style: .headingLg)
                
                HaloText(text: description, style: .bodyLg, color: HaloColor.textSubtle)
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

#Preview {
    MConfirmationView(header: "Got it", description: "We’ve saved your log. You’ll get a reminder in 30 minutes to see how you’re feeling.", image: "ThumbsUp") {}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
