//
//  IconTheme.swift
//  Halo
//
//  Created by Gdwn16 on 25/02/2026.
//

import Foundation
import SwiftUI

public extension Image {
    func resizeImageTo(_ size: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
    }
}
