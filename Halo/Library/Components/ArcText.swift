//
//  ArcText.swift
//  Halo
//

import SwiftUI

struct ArcText: View {
    let text: String
    let radius: CGFloat
    let spacing: Double   // degrees between characters
    let startAngle: Double
    let textColor : Color

    var body: some View {
        ZStack {
            ForEach(Array(text.enumerated()), id: \.offset) { index, character in
                let angle = startAngle + spacing * Double(index)
                let radians = angle * .pi / 180

                Text(String(character))
                    .foregroundStyle(textColor)
                    .multilineTextAlignment(.center)
                    .rotationEffect(.degrees(angle + 90))
                    .offset(
                        x: cos(radians) * radius,
                        y: sin(radians) * radius
                    )
            }
        }
        .frame(width: radius * 2, height: radius * 2)
    }
}
