//
//  Button.swift
//  Halo
//
//  Created by Gdwn16 on 25/02/2026.
//

import SwiftUI

struct MainButton : View {
    
    let state : ButtonStates
    var isLoading : Bool
    let btnLabel : String
    let btnIcon : String?
    let btnImage : String?
    let height : CGFloat
    let fillContainer : Bool
    let tappedButton : () -> Void

    init(
        state: ButtonStates = .primary,
        isLoading : Bool = false,
        label: String = "No label",
         icon: String? = nil,
         image: String? = nil,
         height: CGFloat = 56,
         fillContainer: Bool = false,
         action: @escaping () -> Void) {
             self.state = state
             self.isLoading = isLoading
             self.btnLabel = label
             self.btnIcon = icon
             self.btnImage = image
             self.height = height
             self.fillContainer = fillContainer
             self.tappedButton = action
    }
    
    var body: some View {
        Button (action: tappedButton) {
            Text(btnLabel)
                .foregroundStyle(state.textColor)
        }
        .disabled(state.disabled)
        .buttonStyle(MainButtonStyle(isLoading: isLoading ,icon: btnIcon, image: btnImage, backgroundColor: state.backgroundColor, foregroundColor: state.textColor, height: height, fillContainer: fillContainer))
    }
}

#Preview {
    ZStack {
        Color.clear.noiseBackground()
        VStack {
            MainButton(state: .primary, label: "Sign in with Google", icon: "eye") {}
            MainButton(state: .secondary, label: "Sign in with Google", icon: "eye", fillContainer: true) {}
            MainButton(state: .clear, label: "Sign in with Google", icon: "eye", fillContainer: true) {}
            MainButton(state: .disabled, label: "Sign in with Google", icon: "eye",  fillContainer: true) {}
        }
    }
    .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
}


struct MainButtonStyle : ButtonStyle {
    var isLoading : Bool
    var icon : String?
    var image : String?
    var backgroundColor : Color
    var foregroundColor : Color
    var height : CGFloat
    var fillContainer : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if !isLoading {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundStyle(foregroundColor)
                }
                
                if let image {
                    Image(image)
                        .resizeImageTo(18)
                }
                
                configuration.label
                    .fontStyle(.btnLg)

            } else {
                ProgressView()
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .frame(height: height)
        .frame(maxWidth: fillContainer ? .infinity : .none)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: .infinity))
        .opacity(configuration.isPressed ? 0.7 : 1) // have the click effect
        .scaleEffect(configuration.isPressed ? 0.8 : 1) // slightly scale down
        .animation(.easeInOut(duration: 0.2), value: configuration.isPressed) // animate it
    }
}


enum ButtonStates {
    case primary
    case secondary
    case disabled
    case clear
    
    var backgroundColor: Color {
        switch self {
        case .primary: return HaloColor.buttonBrandPrimaryRest
        case .secondary: return HaloColor.buttonBrandSecondaryRest
        case .disabled: return HaloColor.buttonBrandPrimaryDisabled
        case .clear: return Color.clear
        }
    }
    
    var textColor: Color {
        switch self {
        case .primary: return HaloColor.textInverse
        case .secondary: return HaloColor.textBold
        case .disabled: return HaloColor.textMinimal
        case .clear: return BrandColor.Powder.powder100
        }
    }
    
    var disabled : Bool {
        switch self {
        case .primary, .secondary, .clear: return false
        case .disabled: return true
        }
    }
}
