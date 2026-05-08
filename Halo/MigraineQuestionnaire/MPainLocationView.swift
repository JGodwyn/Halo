//
//  MPainLocationView.swift
//  Halo
//
//  Created by Gdwn16 on 06/05/2026.
//

import SwiftUI

struct MPainLocationView: View {
    @State private var locations : Set<String> = [] // what goes to the model
    @Binding var mainLocations : [String] // what goes to the model
    let tappedContinue : () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading,  spacing: 16) {
                    HaloText(text: "Where was the pain?", style: .headingMd)
                    HaloText(text: "In what part of your head did you feel the pain most of the time? Select as many as you want.", color: HaloColor.textSubtle)
                }
                .padding(.bottom, 24)
                
                FlowLayout {
                    ForEach(PainLocation.allCases, id: \.self) { location in
                        SelectPainLocation(label: location.label, image: location.image, active: locations.contains(location.rawValue)) {
                            if location.rawValue == "unknown" {
                                popAllExceptMe(location.rawValue)
                            } else {
                                modifyLocations(location.rawValue)
                            }
                        }
                    }
                }
                
                MainButton(state: isValid ? .primary : .disabled, label: "Continue", fillContainer: true) {
                    mainLocations = locations.sorted()
                    tappedContinue()
                }
                .padding(.top, 24)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, Padding.mgnMobile)
        .scrollIndicators(.hidden)
        .onAppear {
            locations = Set(mainLocations)
        }
        .onChange(of: locations) { _, _ in
            mainLocations = locations.sorted()
        }
    }
    
    private func modifyLocations(_ item: String) {
        withAnimation(.easeOut(duration: 0.3)) {
            locations.remove("unknown")
            if locations.contains(item) {
                locations.remove(item)
            } else {
                locations.insert(item)
            }
        }
    }
    
    private func popAllExceptMe(_ item: String) {
        withAnimation(.easeOut(duration: 0.3)) {
            if locations.contains(item) {
                locations.remove(item)
            } else {
                locations = [item]
            }
        }
    }
    
    private var isValid : Bool {
        locations.isEmpty == false
    }
}

#Preview {
    MPainLocationView(mainLocations: .constant([])){}
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
