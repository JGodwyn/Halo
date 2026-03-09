//
//  MigraineTypeView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI

struct MAuraPresentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading,  spacing: 16) {
                HaloText(text: "Is the Aura present?", style: .headingMd)
                HaloText(text: "Do you see any flashing lights or blind spots?", color: HaloColor.textSubtle)
            }
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SelectPill(label: "Yes, the aura is present", toggleable: true) { }
            SelectPill(label: "No, there’s no aura", toggleable: true) { }
            SelectPill(label: "I can’t tell for now", toggleable: true) { }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Padding.mgnMobile)
    }
}

#Preview {
    MAuraPresentView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
