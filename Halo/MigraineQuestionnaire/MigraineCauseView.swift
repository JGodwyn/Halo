//
//  MigraineCauseView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI

struct MigraineCauseView: View {
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                HaloText(text: "What do you think might have caused this?", style: .headingMd)
                HaloText(text: "It’s more than normal if you’re not sure. Select as many as you want.", color: HaloColor.textSubtle)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Padding.mgnMobile)
    }
}

#Preview {
    MigraineCauseView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
