//
//  TypographyTheme.swift
//  Halo
//
//  Created by Gdwn16 on 23/02/2026.
//

import Foundation
import SwiftUI

//public enum BaseTypography {
//    // MARK: - Header font
//    public static func Header(_ size : CGFloat) -> Font {
//        .custom("LibreCaslonCondensed-SemiBold", size: size)
//    }
//    
//    // MARK: - Body regular font
//    public static func BodyRegular (_ size  : CGFloat) -> Font {
//        .custom("LibreCaslonText-Regular", size: size)
//    }
//    
//    // MARK: - Body bold font
//    public static func BodyBold (_ size  : CGFloat) -> Font {
//        .custom("LibreCaslonText-Bold", size: size)
//    }
//    
//    // MARK: - Body bold font
//    public static func BodyItalic (_ size  : CGFloat) -> Font {
//        .custom("LibreCaslonText-Italic", size: size)
//    }
//}
//
//public enum HaloType {
//    public static let displayLg = BaseTypography.Header(24)
//}

public struct HaloTextStyle {
    let fontName: String
    let size: CGFloat
    let relativeTo: Font.TextStyle
    
    let kerning: CGFloat?
    let lineSpacing: CGFloat?
    let textCase: Text.Case?
    
    public init(
        fontName: String,
        size: CGFloat,
        relativeTo: Font.TextStyle,
        kerning: CGFloat? = nil,
        lineSpacing: CGFloat? = nil,
        textCase: Text.Case? = nil
    ) {
        self.fontName = fontName
        self.size = size
        self.relativeTo = relativeTo
        self.kerning = kerning
        self.lineSpacing = lineSpacing
        self.textCase = textCase
    }
    
//    public var font: Font {
//        let base = Font.custom(fontName, size: size, relativeTo: relativeTo)
//        return base
//    }
}


public enum HaloFont {
    
    // all the font styles
    private static let header = "LibreCaslonCondensed-SemiBold"
    private static let bodyRegular = "LibreCaslonText-Regular"
    private static let bodyBold = "LibreCaslonText-Bold"
    private static let bodyItalic = "LibreCaslonText-Italic"
    
    
    // MARK: - Display
    
    public static let displayLg = HaloTextStyle(
        fontName: header,
        size: 83,
        relativeTo: .largeTitle,
        kerning: -3
    )
    
    public static let displayMd: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 67,
        relativeTo: .largeTitle,
        kerning: -3
    )
    
    public static let displaySm: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 53,
        relativeTo: .largeTitle,
        kerning: -3
    )
    
    
    // MARK: - Heading
    
    public static let headingLg: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 43,
        relativeTo: .title,
        kerning: -3
    )
    
    public static let headingMd: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 34,
        relativeTo: .title,
        kerning: -3
    )
    
    public static let headingSm: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 27,
        relativeTo: .title,
        kerning: -3
    )
    
    
    // MARK: - Title
    
    public static let titleLg: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 22,
        relativeTo: .title2,
        kerning: -3
    )
    
    public static let titleMd: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 17,
        relativeTo: .title2,
        kerning: -3
    )
    
    public static let titleSm: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 14,
        relativeTo: .title2,
        kerning: -3
    )
    
    
    // MARK: - Body
    
    public static let bodyLg: HaloTextStyle = HaloTextStyle(
        fontName: bodyRegular,
        size: 17,
        relativeTo: .body,
        kerning: 0
    )
    
    public static let bodyLgBold: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 17,
        relativeTo: .body,
        kerning: 0
    )
    
    public static let bodyMd: HaloTextStyle = HaloTextStyle(
        fontName: bodyRegular,
        size: 14,
        relativeTo: .body,
        kerning: 0
    )
    
    public static let bodyMdBold: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 14,
        relativeTo: .body,
        kerning: 0
    )
    
    public static let bodySm: HaloTextStyle = HaloTextStyle(
        fontName: bodyRegular,
        size: 11,
        relativeTo: .body,
        kerning: 0
    )
    
    public static let bodySmBold: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 11,
        relativeTo: .body,
        kerning: 0
    )
    
    
    // MARK: - Others
    
    public static let btnLg: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 18,
        relativeTo: .body,
        kerning: -2
    )
    
    public static let btnSm: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 10,
        relativeTo: .body,
        kerning: -2
    )
    
    public static  let link: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 17,
        relativeTo: .body,
        kerning: -3
    )
}


public struct HaloTextStyleModifier: ViewModifier {
    let style: HaloTextStyle
    
    public func body(content: Content) -> some View {
        content
            .font(.custom(style.fontName, size: style.size, relativeTo: style.relativeTo))
            .kerning(style.kerning ?? 0)
            .lineSpacing(style.lineSpacing ?? 0)
            .textCase(style.textCase)
    }
}

public extension View {
    func textStyle(_ style: HaloTextStyle) -> some View {
        modifier(HaloTextStyleModifier(style: style))
    }
}
