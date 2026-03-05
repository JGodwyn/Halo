//
//  SelectPill.swift
//  Halo
//
//  Created by Gdwn16 on 04/03/2026.
//

import SwiftUI

struct SelectPill: View {
    
    var label : String
    let toggleable : Bool
    let tappedButton: () -> Void
    
    init(label: String = "What is the label?",
         toggleable: Bool = false,
         tappedButton: @escaping () -> Void) {
        self.label = label
        self.toggleable = toggleable
        self.tappedButton = tappedButton
    }
    
    @State private var toggleState : Bool = false
    
    var body: some View {
        
        Button {
            tappedButton()
            if toggleable {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
                    toggleState.toggle()
                }
            }
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: Radius.radRd)
                        .frame(width: 28, height: 16)
                        .foregroundStyle(toggleState ? BrandColor.Powder.powder300 : BrandColor.Gray.gray400)
                }
                .frame(width: 48, height: 32)
                .background(toggleState ? BrandColor.Powder.powder0 : HaloColor.surface0, in: .rect(cornerRadius: Radius.radRd))
                .overlay {
                    RoundedRectangle(cornerRadius: Radius.radRd)
                        .strokeBorder(toggleState ? BrandColor.Powder.powder150 : HaloColor.borderSubtle, lineWidth: 1)
                }
                
                HaloText(text: label, color: toggleState ? HaloColor.textInverse : HaloColor.textBold)
                    .multilineTextAlignment(.leading)

            }
            .padding(.vertical, Padding.padSm)
            .padding(.leading, Padding.padSm)
            .padding(.trailing, Padding.padXl)
            .background(toggleState ? BrandColor.Powder.powder200 : HaloColor.surface0, in: .rect(cornerRadius: Radius.radRd))
        }
    }
}

#Preview {
    ZStack {
        Color.clear.noiseBackground()
        VStack {
            SelectPill(label: "I think a migraine is coming and i want it to go as fast as possible", toggleable: false){}
            SelectPill(toggleable: true){}
        }
    }
    .environment(AuthManager())
    .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
    .preferredColorScheme(.dark)
}
