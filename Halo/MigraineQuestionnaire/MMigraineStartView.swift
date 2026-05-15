//
//  MMigraineStartView.swift
//  Halo
//
//  Created by Gdwn16 on 14/05/2026.
//

import SwiftUI

struct MMigraineStartView: View {

    @Binding var pickedDay: Date
    @Binding var pickedTime: Date
    let tappedNext: () -> Void

    @State private var showDatePicker = false
    @State private var showTimePicker = false
    @GestureState private var datePressed = false
    @GestureState private var timePressed = false

    // MARK: Derived display values from pickedTime

    private var displayHour: String {
        let h = Calendar.current.component(.hour, from: pickedTime)
        let h12 = h % 12 == 0 ? 12 : h % 12
        return String(format: "%02d", h12)
    }

    private var displayMinute: String {
        let m = Calendar.current.component(.minute, from: pickedTime)
        return String(format: "%02d", m)
    }

    private var displayMeridiem: String {
        Calendar.current.component(.hour, from: pickedTime) < 12 ? "AM" : "PM"
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                HaloText(text: "When did it start?", style: .headingMd)
                HaloText(
                    text: "Set the date and time the migraine began. Don't worry if you're not sure — your best guess is fine.",
                    color: HaloColor.textSubtle
                )
            }
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 12) {
                dateRow
            }
            .padding(.bottom, 32)

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

private extension MMigraineStartView {

    var dateRow: some View {
        VStack(alignment: .leading, spacing: 24) {

            // MARK: Date display — tapping opens date sheet
            HStack {
                HaloText(text: pickedDay.formatted(date: .abbreviated, time: .omitted), style: .titleLg)
                Image(systemName: "pencil")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(HaloColor.surface2, in: RoundedRectangle(cornerRadius: .infinity))
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .updating($datePressed) { _, value, _ in
                        value = true
                    }
                    .onEnded { _ in
                        showDatePicker = true
                    }
            )
            .scaleEffect(datePressed ? 0.7 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: datePressed)
            .sheet(isPresented: $showDatePicker) {
                VStack {
                    HaloDatePicker(
                        selection: $pickedDay,
                        in: Calendar.current.date(byAdding: .year, value: -10, to: Date())!...Date()
                    )
                    .presentationDetents([.height(280)])
                }
                .padding()
            }

            // MARK: Time display — tapping any field opens time sheet
            HStack {
                // Hour
                VStack {
                    HaloText(text: displayHour, style: .headingMd)
                        .frame(width: 80, height: 80)
                        .background(HaloColor.surface0, in: RoundedRectangle(cornerRadius: 16))
                    HaloText(text: "Hour", style: .bodyMd, color: HaloColor.textSubtle)
                }

                HaloText(text: ":", style: .headingMd, color: HaloColor.textSubtle)

                // Minute
                VStack {
                    HaloText(text: displayMinute, style: .headingMd)
                        .frame(width: 80, height: 80)
                        .background(HaloColor.surface0, in: RoundedRectangle(cornerRadius: 16))
                    HaloText(text: "Minute", style: .bodyMd, color: HaloColor.textSubtle)
                }

                HaloText(text: ":", style: .headingMd, color: HaloColor.textSubtle)

                // Meridiem
                VStack {
                    HaloText(text: displayMeridiem, style: .headingMd)
                        .frame(width: 80, height: 80)
                        .background(HaloColor.surface0, in: RoundedRectangle(cornerRadius: 16))
                    HaloText(text: "Meridiem", style: .bodyMd, color: HaloColor.textSubtle)
                        .fixedSize()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .updating($timePressed) { _, value, _ in
                        value = true
                    }
                    .onEnded { _ in
                        showTimePicker = true
                    }
            )
            .scaleEffect(timePressed ? 0.7 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: timePressed)
            .sheet(isPresented: $showTimePicker) {
                VStack {
                    HaloTimePicker(selection: $pickedTime)
                        .presentationDetents([.height(280)])
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
}


// MARK: - Preview

#Preview {
    @Previewable @State var pickedDay: Date = Date()
    @Previewable @State var pickedTime: Date = Date()

    MMigraineStartView(pickedDay: $pickedDay, pickedTime: $pickedTime) {}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
