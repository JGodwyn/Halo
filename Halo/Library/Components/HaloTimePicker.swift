//
//  HaloTimePicker.swift
//  Halo
//

import SwiftUI

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
        VStack {
            HaloText(text: "Choose time", style: .headingSm)
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
}
