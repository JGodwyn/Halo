//
//  MigraineTypeView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI

struct MigraineTypeView: View {
    var body: some View {
        VStack {
            HaloText(text: "Are you having a migraine attack?", style: .headingMd)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Padding.mgnMobile)
    }
}

#Preview {
    MigraineTypeView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
