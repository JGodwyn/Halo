//
//  SelectCircle.swift
//  Halo
//
//  Created by Gdwn16 on 05/05/2026.
//

import SwiftUI

struct SelectCircle: View {
    var label : String
    let size : CGFloat
    var active : Bool
    let tappedCircle: () -> Void
    
    init(label: String = "What is the label?",
         size: CGFloat = 120,
         active: Bool = false,
         tappedCircle: @escaping () -> Void) {
        self.label = label
        self.size = size
        self.active = active
        self.tappedCircle = tappedCircle
    }
    
    var body: some View {
        Button {
            tappedCircle()
        } label: {
            Circle()
                .fill(active ? BrandColor.Powder.powder100 : HaloColor.surface1)
                .stroke(active ? HaloColor.borderInverse : BrandColor.Gray.gray600, style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [1, 8]))
                .frame(width: size)
                .overlay {
                    HaloText(text: label, color: active ? HaloColor.textInverse : HaloColor.textBold)
                }
        }
    }
}

#Preview {
    ZStack {
        Color.clear.noiseBackground()
        SelectCircle(){}
    }
}
