//
//  RoundTextField.swift
//  Halo
//
//  Created by Gdwn16 on 02/03/2026.
//

import SwiftUI

struct RoundTextField: View {
    
    var state : TextFieldStates
    var placeholder : String
    @Binding var boundTo : String
    var height : CGFloat
    
    init(state: TextFieldStates = .base(message: ""),
         placeholder: String = "Enter text here",
         boundTo: Binding<String>,
         height: CGFloat = 56) {
        self.state = state
        self.placeholder = placeholder
        self._boundTo = boundTo
        self.height = height
    }
    
    var body: some View {
        TextField(placeholder, text: $boundTo)
            .disabled(state.isDisabled)
            .customRoundedTextField(state: state, height: height)
    }
}

struct RoundTextArea: View {
    
    var state : TextFieldStates
    var placeholder : String
    @Binding var boundTo : String
    var height : CGFloat
    var cornerRadius : CGFloat
    
    init(state: TextFieldStates = .base(message: ""),
         placeholder: String = "Enter text here",
         boundTo: Binding<String>,
         height: CGFloat = 96,
         cornerRadius : CGFloat = 24
    ) {
        self.state = state
        self.placeholder = placeholder
        self._boundTo = boundTo
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        TextEditor(text: $boundTo)
            .padding(.vertical, 8)
            .padding(.horizontal, -4)
            .scrollContentBackground(.hidden)
            .disabled(state.isDisabled)
            .customRoundedTextField(state: state, height: height, cornerRadius: cornerRadius)
            .overlay(alignment: .topLeading) {
                if boundTo.isEmpty {
                    HaloText(text: placeholder, color: HaloColor.textSubtle)
                        .padding()
                }
            }
    }
}


#Preview {
    ZStack {
        Color.clear.noiseBackground()
        VStack(spacing: 24) {
            RoundTextField(state: .error(message: "This is helper text") ,boundTo: .constant(""))
            
            RoundTextField(state: .base(message: "This is helper text") ,boundTo: .constant(""))
            
            RoundTextField(state: .base(message: "This is helper text") ,boundTo: .constant(""))
            
            RoundTextArea(state: .base(message: "This is helper text") ,boundTo: .constant(""))
            
            MainButton(label: "Remove focus") {}
            
        }
    }
    .environment(AuthManager())
    .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
    .preferredColorScheme(.dark)
}


struct CustomRoundedTextField : ViewModifier {
    var state : TextFieldStates
    var height : CGFloat
    var cornerRadius : CGFloat
    var strokeWidth : CGFloat
    var shadowDepth : CGFloat
    var showShadow : Bool
    var showSymbol : Bool
    @FocusState private var isFocused
    
    func body(content: Content) -> some View {
        var effectiveState : TextFieldStates {
            // i want to have it check that the current state is not
            // success or error. if it is, don't change to focus, else ...
            // if the item is focused, change to focus
            guard self.state.stripMessage() != "success" && self.state.stripMessage() != "error" else {
                return state
            }
            
            return state
            
        }
        
        VStack(alignment: .leading) {
            content
                .focused($isFocused)
                .padding(.horizontal)
                .frame(height: height)
                .background(effectiveState.backgroundColor, in: .rect(cornerRadius: cornerRadius, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(effectiveState.strokeColor, lineWidth: strokeWidth)
                        .strokeBorder(isFocused ? BrandColor.Powder.powder200 : .clear, lineWidth: strokeWidth)
                    
                    if showShadow {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.black.opacity(0.2), lineWidth: shadowDepth)
                            .blur(radius: 6)
                            .offset(x: 1, y: 1)
                            .mask(RoundedRectangle(cornerRadius: cornerRadius))
                    }
                }
                .overlay(alignment: .trailing) {
                    if showSymbol {
                        if let theImage = effectiveState.symbol {
                            Image(systemName: theImage)
                                .foregroundStyle(effectiveState.helperTextColor)
                                .font(.system(size: 22))
                                .padding(.horizontal, 12)
                                .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
                                .transition(.blurReplace)
                        }
                    }
                    
                }
            
            if !effectiveState.helperText.isEmpty {
                Text(effectiveState.helperText)
                    .foregroundStyle(effectiveState.helperTextColor)
                    .transition(.blurReplace)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: state)
        .animation(.easeInOut(duration: 0.3), value: effectiveState)
        .animation(.easeInOut(duration: 0.1), value: isFocused)
    }
}

enum TextFieldStates : Equatable {
    case base(message : String)
    case error(message : String)
    case success(message : String)
    case disabled(message : String)
    
    func stripMessage() -> String {
        switch self {
        case .base:
            return "base"
        case .error:
            return "error"
        case .success:
            return "success"
        case .disabled:
            return "disabled"
        }
    }
    
    var isDisabled: Bool {
        switch self {
        case .base, .error, .success:
            return false
        case .disabled:
            return true
        }
    }
    
    var backgroundColor : Color {
        switch self {
        case .base:
            return HaloColor.textInputSurfaceRest
        case .error:
            return .red.opacity(0.1)
        case .success:
            return .green.opacity(0.1)
        case .disabled:
            return BrandColor.Gray.gray100
        }
    }
    
    var strokeColor : Color {
        switch self {
        case .base:
            return BrandColor.Gray.gray300
        case .error:
            return .red
        case .success:
            return .green
        case .disabled:
            return BrandColor.Gray.gray200
        }
    }
    
    var helperText : String {
        switch self {
        case .base(let message):
            return message
        case .error(let message):
            return message
        case .success(let message):
            return message
        case .disabled(let message):
            return message
        }
    }
    
    var helperTextColor : Color {
        switch self {
        case .base:
            return HaloColor.textSubtle
        case .error:
            return .red
        case .success:
            return Color(hex: "00A600")
        case .disabled:
            return HaloColor.textSubtle
        }
    }
    
    var symbol : String? {
        switch self {
        case .base:
            return nil // never use this
        case .error:
            return "exclamationmark.octagon.fill"
        case .success:
            return "checkmark"
        case .disabled:
            return nil
        }
    }
}

extension View {
    func customRoundedTextField(
        state : TextFieldStates = .base(message: ""),
        height : CGFloat = 40,
        cornerRadius : CGFloat = .infinity,
        strokeWidth : CGFloat = 2,
        shadowDepth : CGFloat = 2,
        showShadow : Bool = true,
        showSymbol : Bool = true,
    ) -> some View {
        self.modifier(CustomRoundedTextField(state: state, height: height, cornerRadius: cornerRadius, strokeWidth: strokeWidth, shadowDepth: shadowDepth, showShadow: showShadow, showSymbol: showSymbol))
    }
}

