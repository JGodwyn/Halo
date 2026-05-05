//
//  MigraineQuestionTemplateView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI

struct MigraineQuestionTemplateView: View {
    
    @Environment(\.dismissWithNoise) var dismissWithNoise
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
                        if isFirstTab {
                            tappedCancel()
                        } else {
                            movePrevTab()
                        }
                    } label: {
                        Image(systemName: currentTab == 0 ? "xmark" : "arrow.turn.up.left")
                                .padding(.horizontal, 4)
                                .frame(height: 32)
                    }
                    .buttonStyle(.glass)
                    
                    Spacer()
                    
                    Text("\(currentTab + 1) / \(totalTabs)")
                        .fontStyle(.bodyLg, color: HaloColor.textSubtle)
                        .contentTransition(.numericText())
                    
                    Spacer()
                    
                    Button {
                        if isLastTab {
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 1)) {
                                EndLogging = true
                            }
                        } else {
                            moveNextTab()
                        }
                    } label: {
                        HaloText(text: isLastTab ? "Submit" : "Skip", color: HaloColor.textSubtle)
                            .frame(width: 64)
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
                MConfirmationView(header: migraineSituation.loggingConfirmationHeader, description: migraineSituation.loggingConfirmationDescription) {

                }
                .noiseBackground(transitions: true, isPresented: $EndLogging)
                .transition(.blurReplace.combined(with: .scale(1.2, anchor: .center)))
            }
        }
        .onChange(of: EndLogging) { oldValue, newValue in
            if oldValue == true && newValue == false {
                tappedCancel()
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
        if EndOfFlow {
            EndLogging = true
        } else {
            currentTab = min(totalTabs - 1, currentTab + 1)
        }
    }
    
    func movePrevTab() {
        currentTab = max(0, currentTab - 1)
    }
    
    var isLastTab: Bool { currentTab == totalTabs - 1 }
    var isFirstTab: Bool { currentTab == 0 }
}
