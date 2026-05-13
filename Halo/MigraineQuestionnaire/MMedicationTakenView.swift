//
//  MMedicationView.swift
//  Halo
//
//  Created by Gdwn16 on 08/05/2026.
//

import SwiftUI

struct MMedicationTakenView: View {
    
    @Binding var medTaken : MedicationTaken?
    @Binding var medNote : String
    @Namespace private var noteNS
    let tappedPill : () -> Void
    
    @State private var expandNote : Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                HaloText(text: "Did you take any medications?", style: .headingMd)
                HaloText(text: "Any medicines you took to ease the pain?", color: HaloColor.textSubtle)
            }
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(MedicationTaken.allCases, id: \.self) { taken in
                SelectPill(label: taken.label, toggleable: true, active: taken == medTaken) {
                    medTaken = taken
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
    }
}

#Preview {
    @Previewable @State var medNote : String = ""
    @Previewable @State var medTaken : MedicationTaken?
    
    MMedicationTakenView(medTaken: $medTaken, medNote: $medNote){ }
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}

extension MMedicationTakenView {
    
    var collapsedNote : some View {
        HStack {
            HStack {
                Image("StickyNote")
                    .resizeImageTo(24)
                HaloText(text: "Add a note", style: .btnLg)
                    .fixedSize()
            }
            .matchedGeometryEffect(id: "addNote", in: noteNS, properties: [.position, .size])
            
            ZStack {
                RoundTextArea(placeholder: "Type your note here", boundTo: $medNote, backgroundColor: HaloColor.surface1.opacity(1), strokeColor: BrandColor.Gray.gray400.opacity(0), height: 100)
                    .matchedGeometryEffect(id: "textarea", in: noteNS, properties: [.position, .size])
                
                MainButton(label: "Save note") {}
                    .padding(.top, 8)
                    .matchedGeometryEffect(id: "mainBtn", in: noteNS, properties: [.position, .size])
            }
            .frame(width: 0, height: 0)
            .clipped()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 200, style: .continuous)
                .fill(HaloColor.surface1)
                .matchedGeometryEffect(id: "cardbg", in: noteNS)
        }
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7)) {
                expandNote = true
            }
        }
    }
    
    var expandedNote : some View {
        VStack(alignment: .leading) {
            HaloText(text: "Add your note", style: .headingSm ,color: HaloColor.textSubtle)
                .fixedSize()
                .matchedGeometryEffect(id: "addNote", in: noteNS, properties: [.position, .size])
            RoundTextArea(placeholder: "Type your note here", boundTo: $medNote, backgroundColor: HaloColor.surface1.opacity(1), strokeColor: BrandColor.Gray.gray400.opacity(0), height: 320)
                .matchedGeometryEffect(id: "textarea", in: noteNS, properties: [.position, .size])
            
            MainButton(state: medNote.isEmpty ? .disabled : .primary, label: "Save note", fillContainer: true) {
                
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
        .overlay(alignment: .topTrailing) {
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
        }
        .padding(.horizontal, 24)
    }
}
