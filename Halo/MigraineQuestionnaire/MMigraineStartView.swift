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
            .onTapGesture { showDatePicker = true }
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
            .onTapGesture { showTimePicker = true }
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

// MARK: - HaloTimePicker (12-hour with AM/PM)

struct HaloTimePicker: View {
    @Binding var selection: Date

    @State private var selectedHour12: Int   // 1–12
    @State private var selectedMinute: Int   // 0–59
    @State private var selectedMeridiem: Int // 0 = AM, 1 = PM

    private let hours12  = Array(1...12)
    private let minutes  = Array(0...59)
    private let meridiems = ["AM", "PM"]

    init(selection: Binding<Date>) {
        self._selection = selection
        let comps = Calendar.current.dateComponents([.hour, .minute], from: selection.wrappedValue)
        let hour24 = comps.hour ?? 0
        let h12    = hour24 % 12 == 0 ? 12 : hour24 % 12
        _selectedHour12   = State(initialValue: h12)
        _selectedMinute   = State(initialValue: comps.minute ?? 0)
        _selectedMeridiem = State(initialValue: hour24 < 12 ? 0 : 1)
    }

    private func commitTime() {
        var hour24 = selectedHour12 % 12           // 12 → 0, 1–11 unchanged
        if selectedMeridiem == 1 { hour24 += 12 }  // PM offset

        var comps = Calendar.current.dateComponents([.year, .month, .day], from: selection)
        comps.hour   = hour24
        comps.minute = selectedMinute
        comps.second = 0
        if let date = Calendar.current.date(from: comps) {
            selection = date
        }
    }

    var body: some View {
        HStack(spacing: 0) {

            // Hour (1–12)
            Picker("Hour", selection: $selectedHour12) {
                ForEach(hours12, id: \.self) { hour in
                    Text(String(format: "%02d", hour)).tag(hour)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 72)
            .clipped()

            HaloText(text: ":", color: HaloColor.textSubtle)
                .frame(width: 16)

            // Minute
            Picker("Minute", selection: $selectedMinute) {
                ForEach(minutes, id: \.self) { minute in
                    Text(String(format: "%02d", minute)).tag(minute)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 72)
            .clipped()

            // AM / PM
            Picker("AM/PM", selection: $selectedMeridiem) {
                ForEach(0..<meridiems.count, id: \.self) { idx in
                    Text(meridiems[idx]).tag(idx)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 72)
            .clipped()
        }
        .onChange(of: selectedHour12)   { commitTime() }
        .onChange(of: selectedMinute)   { commitTime() }
        .onChange(of: selectedMeridiem) { commitTime() }
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
