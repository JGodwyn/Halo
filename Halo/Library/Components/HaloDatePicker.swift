//
//  HaloDatePicker.swift
//  Halo
//

import SwiftUI

struct HaloDatePicker: View {
    @Binding var selection: Date
    var range: ClosedRange<Date>

    @State private var selectedDay: Int
    @State private var selectedMonth: Int
    @State private var selectedYear: Int

    private let months = Calendar.current.monthSymbols

    init(selection: Binding<Date>, in range: ClosedRange<Date>) {
        self._selection = selection
        self.range = range
        let comps = Calendar.current.dateComponents([.day, .month, .year], from: selection.wrappedValue)
        _selectedDay = State(initialValue: comps.day ?? 1)
        _selectedMonth = State(initialValue: comps.month ?? 1)
        _selectedYear = State(initialValue: comps.year ?? 2000)
    }

    private var years: [Int] {
        let startYear = Calendar.current.component(.year, from: range.lowerBound)
        let endYear = Calendar.current.component(.year, from: range.upperBound)
        return Array(startYear...endYear)
    }

    private var daysInMonth: Int {
        let comps = DateComponents(year: selectedYear, month: selectedMonth)
        let date = Calendar.current.date(from: comps)!
        return Calendar.current.range(of: .day, in: .month, for: date)!.count
    }

    private func commitDate() {
        let day = min(selectedDay, daysInMonth)
        var comps = DateComponents()
        comps.day = day
        comps.month = selectedMonth
        comps.year = selectedYear
        if let date = Calendar.current.date(from: comps) {
            selection = date
        }
    }

    var body: some View {
        VStack {
            HaloText(text: "Choose date", style: .headingSm)
            HStack(spacing: 0) {
                // Day
                Picker("Day", selection: $selectedDay) {
                    ForEach(1...daysInMonth, id: \.self) { day in
                        Text("\(day)").tag(day)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 60)
                .clipped()

                // Month
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(months[month - 1]).tag(month)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 130)
                .clipped()

                // Year
                Picker("Year", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text(String(year)).tag(year)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                .clipped()
            }
            .onChange(of: selectedDay) { commitDate() }
            .onChange(of: selectedMonth) { commitDate() }
            .onChange(of: selectedYear) { commitDate() }
        }
    }
}
