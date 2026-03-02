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
    
    private var earliestBirthDate: Date {
        Calendar.current.date(byAdding: .year, value: -120, to: Date())!
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    HaloText(text: "This is your onboarding: ")
                    if let username = auth.userName {
                        HaloText(text: username)
                    }
                }
                
                HStack {
                    HaloText(text: "Your date of birth")
                    Spacer()
                    DatePicker(selection: $dob, in: earliestBirthDate...Date(), displayedComponents: .date) {
                        
                    }
                    .labelsHidden()
                    .colorInvert()
                }
                
                MainButton(label: "Save Profile", fillContainer: true) {
                    Task {
                        await auth.saveProfile(dateOfBirth: dob)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(Padding.mgnMobile)
        .frame(maxWidth: .infinity)
        .noiseBackground()
    }
}

#Preview {
    OnboardingView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
}
