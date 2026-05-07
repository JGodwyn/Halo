//
//  MPainLocationView.swift
//  Halo
//
//  Created by Gdwn16 on 06/05/2026.
//

import SwiftUI

struct MPainLocationView: View {
    @Binding var painLocation : PainLocation?
    let tappedOption : () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,  spacing: 16) {
                HaloText(text: "Where was the pain?", style: .headingMd)
                HaloText(text: "In what part of your head did you feel the pain most of the time? Select as many as you want.", color: HaloColor.textSubtle)
            }
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            FlowLayout {
                ForEach(PainLocation.allCases, id: \.self) { location in
                    SelectPainLocation(label: location.label, image: location.image) {
                        
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Padding.mgnMobile)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    MPainLocationView(painLocation: .constant(.behindEyes)){}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
