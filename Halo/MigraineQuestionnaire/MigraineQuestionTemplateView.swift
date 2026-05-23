//
//  MigraineQuestionTemplateView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI
import SwiftData

// MARK: - Step model

/// Represents a single screen in the questionnaire flow.
/// Using a typed enum means adding a new step = one line here + one case in ScreensToShow.
private enum QuestionStep: Hashable {
    case aura
    case intensity
    case cause
    case painLocation
    case medicationTaken
    case medicationHelped
    case migraineStart
    case duration
}

// MARK: - Main view

struct MigraineQuestionTemplateView: View {

    let migraineSituation: MigraineSituations
    /// Pass a pre-populated draft when continuing an existing episode
    /// (e.g. incoming → resolved, or marking didNotOccur).
    /// Leave nil to start a fresh log.
    var initialDraft: MigraineEpisodeDraft? = nil
    let tappedCancel: () -> Void

    @Environment(\.modelContext) private var modelContext
    @Environment(AuthManager.self) private var auth

    // Draft accumulates answers across every step
    @State private var migraineDraft: MigraineEpisodeDraft = .init()

    // Step tracking — an ordered list of steps for this situation
    @State private var steps: [QuestionStep] = []
    @State private var currentIndex: Int = 0
    // Track direction so the slide transition is always correct
    @State private var goingForward: Bool = true

    @State private var endLogging: Bool = false
    @State private var showRichConfirmationView: Bool = false

    private var totalSteps: Int { steps.count }
    private var isLastStep: Bool { currentIndex == totalSteps - 1 }
    private var isFirstStep: Bool { currentIndex == 0 }
    private var currentStep: QuestionStep? { steps.indices.contains(currentIndex) ? steps[currentIndex] : nil }

    // Asymmetric slide: forward = enter from right / exit to left
    //                   back    = enter from left  / exit to right
    private var stepTransition: AnyTransition {
        .asymmetric(
            insertion: .move(edge: goingForward ? .trailing : .leading).combined(with: .opacity).combined(with: .scale(scale: 0.75, anchor: .trailing)),
            removal:   .move(edge: goingForward ? .leading  : .trailing).combined(with: .opacity).combined(with: .scale(scale: 0.75, anchor: .leading))
        )
    }

    var body: some View {
        ZStack {
            Color.clear.noiseBackground()

            VStack(alignment: .leading, spacing: 24) {

                // MARK: Navigation bar
                HStack {
                    Button {
                        movePrev()
                    } label: {
                        Image(systemName: isFirstStep ? "xmark" : "arrow.turn.up.left")
                            .padding(.horizontal, 4)
                            .frame(height: 32)
                    }
                    .buttonStyle(.glass)

                    Spacer()

                    Text("\(currentIndex + 1) / \(totalSteps)")
                        .fontStyle(.bodyLg, color: HaloColor.textSubtle)
                        .contentTransition(.numericText())
                        .animation(.easeOut(duration: 0.25), value: currentIndex)

                    Spacer()

                    Button {
                        moveNext()
                    } label: {
                        HaloText(text: isLastStep ? "Submit" : "Skip", color: HaloColor.textSubtle)
                            .frame(width: 64)
                    }
                }
                .padding(.horizontal, Padding.mgnMobile)

                // MARK: Step content
                // ZStack with an explicit .id() forces SwiftUI to fully swap the view
                // on step change — each child gets a fresh identity, its own @State,
                // and its own @Namespace, completely isolated from the step transition.
                ZStack {
                    if let step = currentStep {
                        stepView(for: step)
                            .transition(stepTransition)
                            // .id() is the key: SwiftUI treats each step as a brand-new view
                            // rather than trying to diff/reuse the previous one.
                            .id(step)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .animation(.easeInOut(duration: 0.3), value: currentStep)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .onAppear {
            steps = buildSteps(for: migraineSituation)
            if let seed = initialDraft {
                // Continuing an existing episode — restore prior data, then
                // stamp the new migraineType for the phase we're entering.
                migraineDraft = seed
            }
            // Always set to the current flow's type (overrides any seed value)
            migraineDraft.migraineType = migraineSituation.asMigraineType
        }

        // MARK: Overlays (unchanged from original)
        .overlay {
            if endLogging {
                MConfirmationView(
                    header: migraineSituation.loggingConfirmationHeader,
                    description: migraineSituation.loggingConfirmationDescription,
                    image: migraineSituation.loggingConfirmationImage
                ) {
                    withAnimation(.easeOut(duration: 0.3)) { tappedCancel() }
                }
                .noiseBackground(transitions: true, isPresented: $endLogging)
                .transition(.blurReplace.combined(with: .scale(1.2, anchor: .center)))
            }
        }
        .onChange(of: endLogging) { old, new in
            if old == true && new == false {
                withAnimation(.easeOut(duration: 0.3)) { tappedCancel() }
            }
        }
        .overlay {
            if showRichConfirmationView {
                MTakeYourTimeRichView { type in
                    if type == .continueAnyway {
                        withAnimation(.easeOut(duration: 0.3)) { showRichConfirmationView = false }
                        moveNext()
                    } else {
                        migraineDraft.commit(to: modelContext, userId: auth.userId)
                        tappedCancel()
                    }
                }
                .transition(.blurReplace.combined(with: .scale(1.2, anchor: .center)))
            }
        }
    }

    // MARK: - Step order per situation

    private func buildSteps(for situation: MigraineSituations) -> [QuestionStep] {
        switch situation {
        case .active:
            return [.aura, .intensity]
        case .incoming:
            return [.cause, .aura]
        case .aftermath:
            return [.aura, .intensity, .cause, .painLocation, .medicationTaken, .medicationHelped, .migraineStart, .duration]
        case .resolved:
            return [.migraineStart, .duration, .aura, .intensity, .cause, .painLocation, .medicationTaken, .medicationHelped]
        }
    }

    // MARK: - Step → View mapping

    @ViewBuilder
    private func stepView(for step: QuestionStep) -> some View {
        switch step {
        case .aura:
            MAuraPresentView(auraStatus: $migraineDraft.aura) { moveNext() }

        case .intensity:
            MIntensityView(painIntensity: $migraineDraft.painIntensity) { moveNext() }

        case .cause:
            MCauseView(
                mainCauses: $migraineDraft.painCauses,
                writeSomethingElse: $migraineDraft.customCause
            ) { moveNext() }

        case .painLocation:
            MPainLocationView(mainLocations: $migraineDraft.painLocations) {
                withAnimation(.easeOut(duration: 0.3)) {
                    if migraineSituation == .aftermath {
                        showRichConfirmationView = true
                    } else {
                        moveNext()
                    }
                }
            }

        case .medicationTaken:
            MMedicationTakenView(
                medTaken: $migraineDraft.medicationTaken,
                medNote: $migraineDraft.medicationTakenNote
            ) { moveNext() }

        case .medicationHelped:
            MMedicationHelpedView(
                medHelped: $migraineDraft.medicationHelped,
                medNote: $migraineDraft.medicationHelpedNote
            ) { moveNext() }

        case .migraineStart:
            MMigraineStartView(
                pickedDay: $migraineDraft.pickedDay,
                pickedTime: $migraineDraft.pickedTime
            ) { moveNext() }

        case .duration:
            MDurationView(
                durationHours: $migraineDraft.durationHours,
                durationMinutes: $migraineDraft.durationMinutes
            ) { moveNext() }
        }
    }
}

// MARK: - Navigation helpers

private extension MigraineQuestionTemplateView {

    func moveNext() {
        if isLastStep {
            migraineDraft.commit(to: modelContext, userId: auth.userId)
            withAnimation(.easeOut(duration: 0.3)) { endLogging = true }
        } else {
            goingForward = true
            withAnimation(.easeInOut(duration: 0.3)) {
                currentIndex = min(totalSteps - 1, currentIndex + 1)
            }
        }
    }

    func movePrev() {
        if isFirstStep {
            tappedCancel()
        } else {
            goingForward = false
            withAnimation(.easeInOut(duration: 0.3)) {
                currentIndex = max(0, currentIndex - 1)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MigraineQuestionTemplateView(migraineSituation: .resolved) {

    }
    .modelContainer(for: MigraineEpisode.self, inMemory: true)
    .environment(AuthManager())
    .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
    .preferredColorScheme(.dark)
}
