//
//  MigraineQuestionTemplateView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI

struct MigraineQuestionTemplateView: View {
    
    let migraineSituation : MigraineSituations
    let tappedCancel : () -> Void
    @State private var allowSwipe = true
    
    
    var body: some View {
        // this is just a template to hold other view
        // - But depending on your selection, the screens change.
        // - The screens can be held in an array.
        ZStack {
            Color.clear.noiseBackground()
            
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Button {
                        tappedCancel()
                    } label: {
                        Image(systemName: "arrow.turn.up.left")
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.glass)
                    
                    Spacer()
                    HaloText(text: "Skip this", color: HaloColor.textSubtle)
                }
                .padding(.horizontal, Padding.mgnMobile)
                
                TabView {
                    MCauseView()
                        .gesture(allowSwipe ? nil : DragGesture())
                    
                    MAuraPresentView()
                    
                    MainButton(label: "Cancel") {
                        tappedCancel()
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    MigraineQuestionTemplateView(migraineSituation: .active) {}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
