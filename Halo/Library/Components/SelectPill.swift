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
    var active : Bool
    
    init(label: String = "What is the label?",
         toggleable: Bool = false,
         active: Bool = false,
         tappedButton: @escaping () -> Void) {
        self.label = label
        self.toggleable = toggleable
        self.active = active
        self.tappedButton = tappedButton
    }
    
    var shouldToggle : Bool {
        guard toggleable == true else { return false }
        return active
    }
    
    var body: some View {
        
        Button {
            tappedButton()
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: Radius.radRd)
                        .frame(width: 28, height: 16)
                        .foregroundStyle(shouldToggle ? BrandColor.Powder.powder300 : BrandColor.Gray.gray400)
                }
                .frame(width: 48, height: 32)
                .background(shouldToggle ? BrandColor.Powder.powder0 : HaloColor.surface0, in: .rect(cornerRadius: Radius.radRd))
                .overlay {
                    RoundedRectangle(cornerRadius: Radius.radRd)
                        .strokeBorder(shouldToggle ? BrandColor.Powder.powder150 : HaloColor.borderSubtle, lineWidth: 1)
                }
                
                HaloText(text: label, color: shouldToggle ? HaloColor.textInverse : HaloColor.textBold)
                    .multilineTextAlignment(.leading)

            }
            .padding(.vertical, Padding.padSm)
            .padding(.leading, Padding.padSm)
            .padding(.trailing, Padding.padXl)
            .background(shouldToggle ? BrandColor.Powder.powder200 : HaloColor.surface0, in: .rect(cornerRadius: Radius.radRd))
            .animation(.easeInOut, value: shouldToggle)
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
