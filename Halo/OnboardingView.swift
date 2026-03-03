//
//  OnboardingView.swift
//  Halo
//
//  Created by Gdwn16 on 28/02/2026.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(AuthManager.self) var auth
    @State private var dob : Date = Date()
    @State private var userName : String = ""
    @State private var showDatePicker = false
    
    private var earliestBirthDate: Date {
        Calendar.current.date(byAdding: .year, value: -120, to: Date())!
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                
                Image("FullLogo")
                    .resizeImageTo(120)
                
                VStack {
                    Text("Hi there, \(userName)")
                        .fontStyle(.titleLg, color: HaloColor.textSubtle)
                        .multilineTextAlignment(.center)
                    
                    HaloText(text: "Just the following to complete your account", style: .headingSm)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 16) {
                    RoundTextField(placeholder: "Your name here", boundTo: $userName)
                    
                    HStack {
                        HaloText(text: "Your date of birth", color: HaloColor.textSubtle)
                        Spacer()
                        Button {
                            showDatePicker = true
                        } label: {
                            HaloText(text: dob.formatted(date: .abbreviated, time: .omitted))
                            .padding(.trailing, 16)
                            .padding(.leading, 16)
                            .padding(.vertical, 8)
                            .background(HaloColor.surface0, in: RoundedRectangle(cornerRadius: .infinity))
                        }
                    }
                    .padding(.trailing, 8)
                    .padding(.leading, 16)
                    .padding(.vertical, 8)
                    .background(HaloColor.surface1, in: RoundedRectangle(cornerRadius: .infinity))
                    .sheet(isPresented: $showDatePicker) {
                        VStack {
                            HaloDatePicker(selection: $dob, in: earliestBirthDate...Date())
                                .presentationDetents([.height(280)])
                        }
                        .padding()
                    }
                    
                    
                }
                
                MainButton(label: "Continue", fillContainer: true) {
                    Task {
                        await auth.saveProfile(username: userName, dateOfBirth: dob)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .padding(.horizontal, Padding.mgnMobile)
        .frame(maxWidth: .infinity)
        .noiseBackground()
        .onAppear {
            userName = auth.userName ?? ""
        }
    }
}

#Preview {
    OnboardingView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}


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
