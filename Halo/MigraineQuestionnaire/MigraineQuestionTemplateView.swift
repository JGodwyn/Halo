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
    @State private var showRichConfirmationView : Bool = false

    var isLastTab: Bool { currentTab == totalTabs - 1 }
    var isFirstTab: Bool { currentTab == 0 }
    
    var body: some View {
        ZStack {
            Color.clear.noiseBackground()
            
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Button {
                        movePrevTab()
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
                        moveNextTab()
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
        .overlay {
            if EndLogging {
                MConfirmationView(header: migraineSituation.loggingConfirmationHeader, description: migraineSituation.loggingConfirmationDescription, image: migraineSituation.loggingConfirmationImage) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        tappedCancel()
                    }
                }
                .noiseBackground(transitions: true, isPresented: $EndLogging)
                .transition(.blurReplace.combined(with: .scale(1.2, anchor: .center)))
            }
        }
        .onChange(of: EndLogging) { oldValue, newValue in
            if oldValue == true && newValue == false {
                withAnimation(.easeOut(duration: 0.3)) {
                    tappedCancel()
                }
            }
        }
        .overlay {
            if showRichConfirmationView {
                MTakeYourTimeRichView { type in
                    if type == .continueAnyway {
                        withAnimation(.easeOut(duration: 0.3)) {
                            showRichConfirmationView = false
                        }
                        moveNextTab()
                    } else {
                        // if StopForNow, save and close flow
                        tappedCancel()
                    }
                }
                .transition(.blurReplace.combined(with: .scale(1.2, anchor: .center)))
            }
        }
    }
    
    @ViewBuilder
    func ScreensToShow (situation : MigraineSituations) -> some View {
        switch situation {
        case .active:
            MAuraPresentView(auraStatus: $migraineDraft.aura) {
                moveNextTab()
            }
            .tag(0)
            
            MIntensityView(painIntensity: $migraineDraft.painIntensity) {
                moveNextTab()
            }
            .tag(1)
            
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
            MAuraPresentView(auraStatus: $migraineDraft.aura) {
                moveNextTab()
            }
            .tag(0)
            
            MIntensityView(painIntensity: $migraineDraft.painIntensity) {
                moveNextTab()
            }
            .tag(1)
            
            MCauseView(mainCauses: $migraineDraft.painCauses ,writeSomethingElse: $migraineDraft.customCause) {
                moveNextTab()
            }
            .tag(2)
            
            MPainLocationView(mainLocations: $migraineDraft.painLocations) {
                withAnimation(.easeOut(duration: 0.3)) {
                    showRichConfirmationView = true
                }
            }
            .tag(3)
            
            MMedicationTakenView(medTaken: $migraineDraft.medicationTaken, medNote: $migraineDraft.medicationTakenNote) {
                moveNextTab()
            }
            .tag(4)
            
        case .resolved:
            EmptyView()
        }
    }
}

#Preview {
    MigraineQuestionTemplateView(migraineSituation: .aftermath, totalTabs: MigraineSituations.aftermath.numberOfTabs) {}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}


extension MigraineQuestionTemplateView {
    func moveNextTab() {
        if isLastTab {
            withAnimation(.easeOut(duration: 0.3)) {
                EndLogging = true
            }
        } else {
            withAnimation(.easeOut(duration: 0.3)) {
                currentTab = min(totalTabs - 1, currentTab + 1)
            }
        }
    }
    
    func movePrevTab() {
        if isFirstTab {
            tappedCancel()
        } else {
            withAnimation(.easeOut(duration: 0.3)) {
                currentTab = max(0, currentTab - 1)
            }
        }
    }
}
