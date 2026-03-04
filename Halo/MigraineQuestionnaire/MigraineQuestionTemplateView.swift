//
//  MigraineQuestionTemplateView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI

struct MigraineQuestionTemplateView: View {
    var body: some View {
        // this is just a template to hold other view
        ZStack {
            Color.clear.noiseBackground()
            TabView {
                MigraineTypeView()
                MigraineCauseView()
            }
            .tabViewStyle(.page)
        }
    }
}

#Preview {
    MigraineQuestionTemplateView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
