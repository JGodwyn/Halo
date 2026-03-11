//
//  MigraineQuestionTemplateView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI

struct MigraineQuestionTemplateView: View {
    
    let migraineSituation : MigraineSituations
    let totalTabs : Int
    @State private var currentTab = 0
    
    let tappedCancel : () -> Void // close the view
    @State private var allowSwipe = true
    @State private var migraineDraft : MigraineEpisodeDraft = .init()
    
    @State private var EndLogging : Bool = false
    
    var EndOfFlow : Bool {
        if currentTab + 1  == totalTabs {
            return true
        }
        return false
    }
    
    
    var body: some View {
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
                    
                    Text("\(currentTab + 1) / \(totalTabs)")
                        .fontStyle(.bodyLg, color: HaloColor.textSubtle)
                        .contentTransition(.numericText())
                    
                    Spacer()
                    
                    Button {
                        moveNextTab()
                    } label: {
                        HaloText(text: "Skip", color: HaloColor.textSubtle)
                    }
                }
                .padding(.horizontal, Padding.mgnMobile)
                
                TabView(selection: $currentTab) {
                    ScreensToShow(situation: migraineSituation)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .animation(.smooth, value: currentTab)
        .overlay {
            if EndLogging {
                MConfirmationView(header: "Got it", description: "I am describing something here") {
                    EndLogging = false
                }
                .transition(.blurReplace)
            }
        }
    }
    
    @ViewBuilder
    func ScreensToShow (situation : MigraineSituations) -> some View {
        switch situation {
        case .active:
            EmptyView()
            
        case .incoming:
            MCauseView(mainCauses: $migraineDraft.painCauses ,writeSomethingElse: $migraineDraft.customCause) {
                moveNextTab()
            }
            .gesture(allowSwipe ? nil : DragGesture())
            .tag(0)
            
            MAuraPresentView(auraStatus: $migraineDraft.aura) {
                moveNextTab()
            }
            .tag(1)
            
        case .aftermath:
            EmptyView()
            
        case .resolved:
            EmptyView()
        }
    }
}

#Preview {
    MigraineQuestionTemplateView(migraineSituation: .incoming, totalTabs: MigraineSituations.incoming.numberOfTabs) {}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}


extension MigraineQuestionTemplateView {
    func moveNextTab() {
        currentTab = min(totalTabs - 1, currentTab + 1)
    }
    
    func movePrevTab() {
        currentTab = max(0, currentTab - 1)
    }
}
