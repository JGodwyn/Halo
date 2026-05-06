//
//  MIntensityView.swift
//  Halo
//
//  Created by Gdwn16 on 05/05/2026.
//

import SwiftUI

struct MIntensityView: View {
    
    @Binding var painIntensity : PainIntensity?
    let tappedOption : () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading,  spacing: 16) {
                HaloText(text: "How intense is the pain?", style: .headingMd)
                HaloText(text: "You can always change this later", color: HaloColor.textSubtle)
            }
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            FlowLayout(spacing: 16, alignment: .leading) {
                ForEach(PainIntensity.allCases, id: \.self) { cause in
                    SelectCircle(label: cause.label, size: decideSize(cause)) {
                        tappedOption()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Padding.mgnMobile)
    }
}

#Preview {
    MIntensityView(painIntensity: .constant(.intense)){}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}

extension MIntensityView {
    func decideSize(_ obj : PainIntensity) -> CGFloat {
        switch obj {
        case .intense :
            return 160
        case .moderate:
            return 136
        case .mild:
            return 104
        }
    }
}
