//
//  OtherStyles.swift
//  Halo
//
//  Created by Gdwn16 on 06/03/2026.
//

import Foundation
import SwiftUI

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
