//
//  HaloDurationPicker.swift
//  Halo
//

import SwiftUI

struct HaloDurationPicker: View {

    @Binding var hours: Int?
    @Binding var minutes: Int?

    @State private var selectedHours: Int
    @State private var selectedMinutes: Int

    private let hourRange   = Array(0...72)  // up to 72 hrs
    private let minuteRange = Array(0...59)

    init(hours: Binding<Int?>, minutes: Binding<Int?>) {
        self._hours   = hours
        self._minutes = minutes
        _selectedHours   = State(initialValue: hours.wrappedValue   ?? 0)
        _selectedMinutes = State(initialValue: minutes.wrappedValue ?? 0)
    }

    var body: some View {
        VStack {
            HaloText(text: "Choose duration", style: .headingSm)
            HStack(spacing: 0) {

                // Hours
                Picker("Hours", selection: $selectedHours) {
                    ForEach(hourRange, id: \.self) { h in
                        Text(String(format: "%02d", h)).tag(h)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                .clipped()

                HaloText(text: "h", color: HaloColor.textSubtle)
                    .frame(width: 24)

                // Minutes
                Picker("Minutes", selection: $selectedMinutes) {
                    ForEach(minuteRange, id: \.self) { m in
                        Text(String(format: "%02d", m)).tag(m)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                .clipped()

                HaloText(text: "m", color: HaloColor.textSubtle)
                    .frame(width: 24)
            }
            .onChange(of: selectedHours)   { hours   = selectedHours }
            .onChange(of: selectedMinutes) { minutes = selectedMinutes }
        }
    }
}
