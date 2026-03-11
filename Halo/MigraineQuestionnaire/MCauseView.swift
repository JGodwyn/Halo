//
//  MigraineCauseView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI
import SwiftData

struct MCauseView: View {
    
    @State private var causes : Set<String> = [] // what goes to the model
    
    @Binding var mainCauses : [String] // what goes to the model
    @Binding var writeSomethingElse : String
    let tappedContinue : () -> Void
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading,  spacing: 16) {
                    HaloText(text: "What do you think might have caused this?", style: .headingMd)
                    HaloText(text: "It’s more than normal if you’re not sure. Select as many as you want.", color: HaloColor.textSubtle)
                }
                .padding(.bottom, 24)
                
                ForEach(PainCause.allCases, id: \.self) { cause in
                    
                    if cause.rawValue == "other" {
                        SelectPill(label: cause.label, toggleable: true, active: causes.contains(cause.rawValue)) {
                            modifyCauses(cause.rawValue)
                        }
                    } else if cause.rawValue == "unknown"{
                        SelectPill(label: cause.label, toggleable: true, active: causes.contains(cause.rawValue)) {
                            popAllExceptMe(cause.rawValue)
                        }
                    } else {
                        SelectPill(label: cause.label, toggleable: true, active: causes.contains(cause.rawValue)) {
                            modifyCauses(cause.rawValue)
                        }
                    }
                }
                
                if causes.contains("other") {
                    RoundTextArea(placeholder: "Write it here", boundTo: $writeSomethingElse)
                        .transition(.blurReplace)
                }
                
                // when i click this button
                // pass the array to the parent struct
                MainButton(state: isValid ? .primary : .disabled, label: "Continue", fillContainer: true) {
                    mainCauses = causes.sorted()
                    tappedContinue()
                }
                .padding(.top, 24)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, Padding.mgnMobile)
        .scrollIndicators(.hidden)
        .animation(.easeInOut, value: causes)
        .animation(.easeInOut(duration: 0.2), value: writeSomethingElse)
        .onAppear {
            mainCauses = causes.sorted()
        }
        .onChange(of: causes) { _, _ in
            mainCauses = causes.sorted()
        }
    }
    
    private func modifyCauses(_ item: String) {
        causes.remove("unknown")
        if causes.contains(item) {
            causes.remove(item)
        } else {
            causes.insert(item)
        }
    }
    
    private func popAllExceptMe(_ item: String) {
        if causes.contains(item) {
            causes.remove(item)
        } else {
            causes = [item]
        }
    }
    
    private var isValid : Bool {
        guard causes.isEmpty == false else {
            return false
        }
        
        if causes.contains("other") && writeSomethingElse.isEmpty {
            return false
        }
        
        return true
    }
}

#Preview {
    MCauseView(mainCauses: .constant([]), writeSomethingElse: .constant("")) { }
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}
