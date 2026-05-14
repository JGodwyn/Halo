//
//  MigraineCauseView.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI
import SwiftData

struct MCauseView: View {
    
    @State private var causes : Set<String> = []
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var textAreaFocused : Bool
    
    @Binding var mainCauses : [String]
    @Binding var writeSomethingElse : String
    let tappedContinue : () -> Void
    
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading,  spacing: 16) {
                        HaloText(text: "What do you think might have caused this?", style: .headingMd)
                        HaloText(text: "It's more than normal if you're not sure. Select as many as you want.", color: HaloColor.textSubtle)
                    }
                    .padding(.bottom, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(PainCause.allCases, id: \.self) { cause in
                        if cause.rawValue == "other" {
                            SelectPill(label: cause.label, toggleable: true, active: causes.contains(cause.rawValue)) {
                                modifyCauses(cause.rawValue)
                                // Delay focus so the blurReplace transition plays
                                // before the keyboard rises and covers the textarea
                                if causes.contains(cause.rawValue) {
                                    Task { @MainActor in
                                        try? await Task.sleep(for: .milliseconds(300))
                                        textAreaFocused = true
                                    }
                                }
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
                            .id("writeOther")
                            .transition(.blurReplace)
                            .focused($textAreaFocused)
                    }
                    
                    // when i click this button
                    // pass the array to the parent struct
                    MainButton(state: isValid ? .primary : .disabled, label: "Continue", fillContainer: true) {
                        mainCauses = causes.sorted()
                        tappedContinue()
                    }
                    .padding(.top, 24)
                    
                    // Elastic spacer — grows to keyboard height so scrollTo
                    // always has room to bring the textarea fully above the keyboard
                    Color.clear.frame(height: keyboardHeight)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, Padding.mgnMobile)
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.interactively)
            .onAppear {
                mainCauses = causes.sorted()
            }
            .onChange(of: causes) { _, newCauses in
                mainCauses = newCauses.sorted()
            }
            // keyboardDidShowNotification fires after the keyboard animation is fully
            // complete — both the final frame and the textarea layout are stable here,
            // making scrollTo reliable with no timing guesswork
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { notification in
                guard causes.contains("other"),
                      let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                else { return }
                keyboardHeight = frame.height
                withAnimation(.easeOut(duration: 0.3)) {
                    proxy.scrollTo("writeOther", anchor: .center)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                withAnimation(.easeOut(duration: 0.25)) {
                    keyboardHeight = 0
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        withAnimation(.easeOut(duration: 0.3)) {
                            textAreaFocused = false
                        }
                    }
                }
            }
        }
    }
    
    private func modifyCauses(_ item: String) {
        withAnimation(.easeInOut) {
            causes.remove("unknown")
            if causes.contains(item) {
                causes.remove(item)
            } else {
                causes.insert(item)
            }
        }
    }
    
    private func popAllExceptMe(_ item: String) {
        withAnimation(.easeInOut) {
            if causes.contains(item) {
                causes.remove(item)
            } else {
                causes = [item]
            }
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
