//
//  MDurationView.swift
//  Halo
//
//  Created by Gdwn16 on 15/05/2026.
//

import SwiftUI

struct MDurationView: View {

    @Binding var durationHours: Int?
    @Binding var durationMinutes: Int?
    let tappedNext: () -> Void

    @State private var showDurationPicker = false
    @GestureState private var isDurationPressed = false

    // MARK: Derived display values

    private var displayHours: String {
        String(format: "%02d", durationHours ?? 0)
    }

    private var displayMinutes: String {
        String(format: "%02d", durationMinutes ?? 0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 16) {
                HaloText(text: "How long did it last?", style: .headingMd)
                HaloText(
                    text: "Give your best guess of how long the migraine lasted. You can update this later.",
                    color: HaloColor.textSubtle
                )
            }
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .leading)

            durationRow
            


            MainButton(label: "Continue", fillContainer: true) {
                tappedNext()
            }
            .padding(.bottom, Padding.mgnMobile)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(Padding.mgnMobile)
    }
}

// MARK: - Subviews

private extension MDurationView {

    var durationRow: some View {
        HStack {
            // Hours
            VStack {
                HaloText(text: displayHours, style: .headingMd)
                    .frame(width: 120, height: 120)
                    .background(HaloColor.surface0, in: RoundedRectangle(cornerRadius: .infinity))
            }
            .overlay (alignment: .top) {
                ArcText(
                    text: "•HOURS•",
                    radius: 60,
                    spacing: 12,       // tweak this to tighten/loosen
                    startAngle: 232,    // -90 starts at top
                    textColor: HaloColor.textSubtle
                )
                .fontStyle(.bodyMd)
                .foregroundStyle(HaloColor.textSubtle)
                .offset(y: -12)
            }

            HaloText(text: ":", style: .headingMd, color: HaloColor.textSubtle)

            // Minutes
            VStack {
                HaloText(text: displayMinutes, style: .headingMd)
                    .frame(width: 120, height: 120)
                    .background(HaloColor.surface0, in: RoundedRectangle(cornerRadius: .infinity))
            }
            .overlay (alignment: .top) {
                ArcText(
                    text: "•MINUTES•",
                    radius: 60,
                    spacing: 12,       // tweak this to tighten/loosen
                    startAngle: 220,    // -90 starts at top
                    textColor: HaloColor.textSubtle
                )
                .fontStyle(.bodyMd)
                .foregroundStyle(HaloColor.textSubtle)
                .offset(y: -12)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .contentShape(Rectangle())
        .scaleEffect(isDurationPressed ? 0.7 : 1.0)
        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isDurationPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isDurationPressed) { _, state, _ in state = true }
                .onEnded { _ in showDurationPicker = true }
        )
        .sheet(isPresented: $showDurationPicker) {
            VStack {
                HaloDurationPicker(hours: $durationHours, minutes: $durationMinutes)
                    .presentationDetents([.height(280)])
            }
            .padding()
        }
    }
}



// MARK: - Preview

#Preview {
    @Previewable @State var durationHours: Int?   = nil
    @Previewable @State var durationMinutes: Int? = nil

    MDurationView(durationHours: $durationHours, durationMinutes: $durationMinutes) {}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}



