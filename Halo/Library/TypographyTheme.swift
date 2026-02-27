//
//  TypographyTheme.swift
//  Halo
//
//  Created by Gdwn16 on 23/02/2026.
//

import Foundation
import SwiftUI


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
    
    private static let header = "LibreCaslonCondensed-SemiBold"
    private static let bodyRegular = "LibreCaslonText-Regular"
    private static let bodyBold = "LibreCaslonText-Bold"
    private static let bodyItalic = "LibreCaslonText-Italic"
}


public extension HaloTextStyle {
    
    // MARK: - Display
    
    static let displayLg = HaloTextStyle(
        fontName: header,
        size: 83,
        relativeTo: .largeTitle,
        kerning: -3
    )
    
    static let displayMd: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 67,
        relativeTo: .largeTitle,
        kerning: -3
    )
    
    static let displaySm: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 53,
        relativeTo: .largeTitle,
        kerning: -3
    )
    
    
    // MARK: - Heading
    
    static let headingLg: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 43,
        relativeTo: .title,
        kerning: -3
    )
    
    static let headingMd: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 34,
        relativeTo: .title,
        kerning: -2
    )
    
    static let headingSm: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 27,
        relativeTo: .title,
        kerning: -3
    )
    
    
    // MARK: - Title
    
    static let titleLg: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 22,
        relativeTo: .title2,
        kerning: -3
    )
    
    static let titleMd: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 17,
        relativeTo: .title2,
        kerning: -3
    )
    
    static let titleSm: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 14,
        relativeTo: .title2,
        kerning: -3
    )
    
    
    // MARK: - Body
    
    static let bodyLg: HaloTextStyle = HaloTextStyle(
        fontName: bodyRegular,
        size: 17,
        relativeTo: .body,
        kerning: 0,
        lineSpacing: 7
    )
    
    static let bodyLgBold: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 17,
        relativeTo: .body,
        kerning: 0,
        lineSpacing: 7
    )
    
    static let bodyMd: HaloTextStyle = HaloTextStyle(
        fontName: bodyRegular,
        size: 14,
        relativeTo: .body,
        kerning: 0,
        lineSpacing: 7
    )
    
    static let bodyMdBold: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 14,
        relativeTo: .body,
        kerning: 0,
        lineSpacing: 7
    )
    
    static let bodySm: HaloTextStyle = HaloTextStyle(
        fontName: bodyRegular,
        size: 11,
        relativeTo: .body,
        kerning: 0,
        lineSpacing: 7
    )
    
    static let bodySmBold: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 11,
        relativeTo: .body,
        kerning: 0,
        lineSpacing: 7
    )
    
    
    // MARK: - Others
    
    static let btnLg: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 18,
        relativeTo: .body,
        kerning: 0
    )
    
    static let btnSm: HaloTextStyle = HaloTextStyle(
        fontName: header,
        size: 10,
        relativeTo: .body,
        kerning: 0
    )
    
    static let link: HaloTextStyle = HaloTextStyle(
        fontName: bodyBold,
        size: 17,
        relativeTo: .body,
        kerning: 0
    )

    
}

public extension View {
    func fontStyle(_ style: HaloTextStyle) -> some View {
        font(.custom(style.fontName, size: style.size, relativeTo: style.relativeTo))
            .kerning(style.kerning ?? 0)
            .lineSpacing(style.lineSpacing ?? 0)
            .textCase(style.textCase)
    }
}


struct HaloText: View {
    let text: String
    var style: HaloTextStyle = .bodyLg
    var color : Color = HaloColor.textBold

    var body: some View {
        Text(text)
            .fontStyle(style)
            .foregroundStyle(color)
    }
}

//public enum AllTextStyles {
//    case displayLg
//    case displayMd
//    case displaySm
//    
//    case headingLg
//    case headingMd
//    case headingSm
//    
//    case titleLg
//    case titleMd
//    case titleSm
//    
//    case bodyLg
//    case bodyLgBold
//    case bodyMd
//    case bodyMdBold
//    case bodySm
//    case bodySmBold
//    
//    case btnLg
//    case btnSm
//    case Link
//    
//    var textStyle: HaloTextStyle {
//        switch self {
//        case .displayLg: return HaloFont.displayLg
//        case .displayMd: return HaloFont.displayMd
//        case .displaySm: return HaloFont.displaySm
//            
//        case .headingLg: return HaloFont.headingLg
//        case .headingMd: return HaloFont.headingMd
//        case .headingSm: return HaloFont.headingSm
//            
//        case .titleLg: return HaloFont.titleLg
//        case .titleMd: return HaloFont.titleMd
//        case .titleSm: return HaloFont.titleSm
//            
//        case .bodyLg: return HaloFont.bodyLg
//        case .bodyLgBold: return HaloFont.bodyLgBold
//        case .bodyMd: return HaloFont.bodyMd
//        case .bodyMdBold: return HaloFont.bodyMdBold
//        case .bodySm: return HaloFont.bodySm
//        case .bodySmBold: return HaloFont.bodySmBold
//            
//        case .btnLg: return HaloFont.btnLg
//        case .btnSm: return HaloFont.btnSm
//        case .Link: return HaloFont.link
//        }
//    }
//}
