//
//  SelectPainLocation.swift
//  Halo
//
//  Created by Gdwn16 on 06/05/2026.
//

import SwiftUI

struct SelectPainLocation: View {
    var label : String
    var image : String
    let width : CGFloat
    var active : Bool
    let tappedCircle: () -> Void
    
    
    init(label: String = "Entire head / Scalp",
         image: String = "BackOfHeadNeck",
         width: CGFloat = 168,
         active: Bool = false,
         tappedCircle: @escaping () -> Void) {
        self.label = label
        self.image = image
        self.width = width
        self.active = active
        self.tappedCircle = tappedCircle
    }
    
    var body: some View {
        Button {
            tappedCircle()
        } label: {
            VStack {
                Image(image)
                    .mask {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .black,
                                .black,
                                .black.opacity(0.25),
                                .black.opacity(0)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomLeading
                        )
                    }
            }
            .frame(width: width, height: 200)
            .background {
                HaloColor.surface2
                if active {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            BrandColor.Lavender.lavender400.opacity(0.5),
                            BrandColor.Lavender.lavender400.opacity(0.15),
                            BrandColor.Lavender.lavender400.opacity(0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.6), value: active)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(alignment: .bottom) {
                HaloText(text: label)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 24)
            }
            .overlay(alignment: .topTrailing) {
                if active {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(BrandColor.Lavender.lavender100, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .fill(BrandColor.Lavender.lavender500)
                        .frame(width: 48, height: 48)
                        .padding(8)
                        .overlay {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                        }
                        .transition(.scale)
                }
            }
        }
    }
}

#Preview {
    ZStack{
        Color.clear.noiseBackground()
        SelectPainLocation(){}
    }
}
