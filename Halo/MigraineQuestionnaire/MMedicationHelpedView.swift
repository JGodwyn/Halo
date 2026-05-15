//
//  MMedicationHelpedView.swift
//  Halo
//
//  Created by Gdwn16 on 14/05/2026.
//

import SwiftUI

struct MMedicationHelpedView: View {
    
    @Binding var medHelped : MedicationHelped?
    @Binding var medNote : String
    @Namespace private var noteNS
    let tappedPill : () -> Void
    
    @FocusState private var noteIsFocused: Bool
    @State private var expandNote : Bool = false
    @State private var saveStatus : Bool = false
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                HaloText(text: "Did this medication help?", style: .headingMd)
                HaloText(text: "Would you say that this medication helped with the pain?", color: HaloColor.textSubtle)
            }
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(MedicationHelped.allCases, id: \.self) { option in
                SelectPill(label: option.label, toggleable: true, active: option == medHelped) {
                    medHelped = option
                    tappedPill()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(Padding.mgnMobile)
        .overlay(alignment: .bottom) {
            ZStack(alignment: .bottom) {
                if expandNote {
                    expandedNote
                        .transition(.blurReplace)
                } else {
                    collapsedNote
                        .transition(.blurReplace)
                }
            }
            .padding(.bottom, 16)
        }
        .animation(.easeOut(duration: 0.3), value: medNote)
        .onChange(of: saveStatus) { _, _ in
            Task {
                try? await Task.sleep(for: .seconds(2))
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7)) {
                    saveStatus = false
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var medNote : String = ""
    @Previewable @State var medHelped : MedicationHelped?
    
    MMedicationHelpedView(medHelped: $medHelped, medNote: $medNote) { }
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}

extension MMedicationHelpedView {
    
    var noteLabel : String {
        guard saveStatus == false else { return "Note saved" }
        if medNote.isEmpty {
            return "Add a note"
        } else {
            return "Edit note"
        }
    }
    
    var collapsedNote : some View {
        HStack {
            HStack {
                Image(systemName: saveStatus ? "checkmark" : "long.text.page.and.pencil.fill")
                    .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
                    .font(.system(size: 16))
                HaloText(text: noteLabel, style: .btnLg)
                    .fixedSize()
            }
            .matchedGeometryEffect(id: "addNote", in: noteNS, properties: [.position, .size])
            
            ZStack {
                RoundTextArea(placeholder: "Type your note here", boundTo: $medNote, backgroundColor: HaloColor.surface1.opacity(1), strokeColor: BrandColor.Gray.gray400.opacity(0), height: 100)
                    .matchedGeometryEffect(id: "textarea", in: noteNS, properties: [.position, .size])
                
                MainButton(label: "Save note") {}
                    .padding(.top, 8)
                    .matchedGeometryEffect(id: "mainBtn", in: noteNS, properties: [.position, .size])
                
                Button {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7)) {
                        expandNote = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.glass)
                .padding(4)
                .matchedGeometryEffect(id: "closeBtn", in: noteNS)
            }
            .frame(width: 0, height: 0)
            .clipped()
        }
        .padding(.leading)
        .padding(.trailing, 12)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 200, style: .continuous)
                .fill(HaloColor.surface1)
                .overlay {
                    if !medNote.isEmpty {
                        RoundedRectangle(cornerRadius: .infinity)
                            .strokeBorder(BrandColor.Gray.gray400, lineWidth: 1)
                            .transition(.blurReplace)
                    }
                }
                .matchedGeometryEffect(id: "cardbg", in: noteNS)
        }
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7)) {
                expandNote = true
                Task {
                    try? await Task.sleep(for: .seconds(0.6))
                    noteIsFocused = true
                }
            }
        }
    }
    
    var expandedNote : some View {
        VStack(alignment: .leading) {
            HaloText(text: "Your note", style: .headingSm, color: HaloColor.textSubtle)
                .fixedSize()
                .matchedGeometryEffect(id: "addNote", in: noteNS, properties: [.position, .size])
            RoundTextArea(placeholder: "Type your note here", boundTo: $medNote, backgroundColor: HaloColor.surface0, strokeColor: BrandColor.Gray.gray400.opacity(0), height: 240)
                .focused($noteIsFocused)
                .matchedGeometryEffect(id: "textarea", in: noteNS, properties: [.position, .size])
            
            MainButton(state: medNote.isEmpty ? .disabled : .primary, label: "Save note", fillContainer: true) {
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7)) {
                    expandNote = false
                    saveStatus = true
                    noteIsFocused = false
                }
            }
            .padding(.top, 8)
            .matchedGeometryEffect(id: "mainBtn", in: noteNS, properties: [.position, .size])
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(alignment: .topLeading)
        .background {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(HaloColor.surface1)
                .matchedGeometryEffect(id: "cardbg", in: noteNS)
        }
        .padding(.bottom, keyboardHeight)
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7)) {
                    expandNote = false
                    noteIsFocused = false
                }
            } label: {
                Image(systemName: "xmark")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.glass)
            .padding(4)
            .matchedGeometryEffect(id: "closeBtn", in: noteNS)
        }
        .padding(.horizontal, 24)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notif in
            let frame = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
            withAnimation(.easeOut(duration: 0.25)) {
                keyboardHeight = frame.height
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation(.easeOut(duration: 0.25)) {
                keyboardHeight = 0
            }
        }
    }
}
