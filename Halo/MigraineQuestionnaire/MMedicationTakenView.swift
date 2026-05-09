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
//            collapsedNote
            expandedNote
        }
    }
}

#Preview {
    MMedicationTakenView(medTaken: .constant(.yes), medNote: .constant("Nothing here")){ }
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .preferredColorScheme(.dark)
}

extension MMedicationTakenView {
    
    var collapsedNote : some View {
        HStack {
            Image("StickyNote")
                .resizeImageTo(24)
            HaloText(text: "Add a note", style: .btnLg)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(HaloColor.surface0, in: RoundedRectangle(cornerRadius: 200, style: .continuous))
        .matchedGeometryEffect(id: "noteNS", in: noteNS)
    }
    
    var expandedNote : some View {
        VStack(alignment: .leading) {
            HaloText(text: "Adding a note", style: .headingSm ,color: HaloColor.textSubtle)
            RoundTextArea(boundTo: $medNote)
        }
        .padding(.horizontal)
        .padding(.vertical, 16)
        .frame(width: 320, height: 360, alignment: .topLeading)
        .background(HaloColor.surface0, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .matchedGeometryEffect(id: "noteNS", in: noteNS)
        .overlay(alignment: .topTrailing) {
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.glass)
            .padding(4)
        }
    }
}
