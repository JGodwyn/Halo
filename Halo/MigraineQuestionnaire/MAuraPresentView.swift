//
//  MigraineTypeView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI

struct MAuraPresentView: View {
    
    @Binding var auraStatus : AuraStatus?
    let tappedOption : () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading,  spacing: 16) {
                HaloText(text: "Is the Aura present?", style: .headingMd)
                HaloText(text: "Do you see any flashing lights or blind spots?", color: HaloColor.textSubtle)
            }
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(AuraStatus.allCases, id: \.self) { cause in
                SelectPill(label: cause.label, toggleable: true, active: auraStatus == cause) {
                    auraStatus = cause
                    tappedOption()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Padding.mgnMobile)
    }
}

#Preview {
    MAuraPresentView(auraStatus: .constant(.unsure)) {}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
