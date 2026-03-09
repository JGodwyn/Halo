//
//  MigraineCauseView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI
import SwiftData

struct MCauseView: View {
    
    @State private var shouldToggleThisPill: Bool = false
    @State private var causes : Set<String> = [] // what goes to the model
    @State private var writeSomethingElse : String = ""
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading,  spacing: 16) {
                    HaloText(text: "What do you think might have caused this?", style: .headingMd)
                    HaloText(text: "It’s more than normal if you’re not sure. Select as many as you want.", color: HaloColor.textSubtle)
                }
                .padding(.bottom, 24)
                
                ForEach(PainCause.allCases, id: \.self) { cause in
                    SelectPill(label: cause.label, toggleable: true, active: causes.contains(cause.rawValue)) {
                        modifyCauses(cause.rawValue)
                    }
                }
                
                RoundTextField(boundTo: $writeSomethingElse)
                RoundTextArea(state: .base(message: "This is helping you"), boundTo: $writeSomethingElse)
                
                MainButton(label: "Continue", fillContainer: true) {
                    
                }
                .padding(.top, 24)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, Padding.mgnMobile)
        .scrollIndicators(.hidden)
    }
    
    private func modifyCauses(_ item: String) {
        if causes.contains(item) {
            causes.remove(item)
        } else {
            causes.insert(item)
        }
    }
}

#Preview {
    MCauseView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
