// =============================================================================
// HaloTokens.swift
// Auto-generated from Figma variables — do not edit manually.
//
// Alias chain is preserved in Swift:
//   HaloTheme.textBold  →  BrandColor.Gray.gray1000  →  Color(...)
//   Radius.radMd        →  Units.unitsMd              →  8
//
// So editing a Units value cascades through Radius/Distance/Padding,
// and editing a BrandColor cascades through HaloTheme.
// =============================================================================

import SwiftUI
import Foundation

// MARK: - Primitive Color Palettes
// Raw values only. Never reference these directly from UI code.

public enum BrandColor {

    public enum Gray {
        public static let gray0 = Color(red: 0.027451, green: 0.011765, blue: 0.039216, opacity: 1)
        public static let gray50 = Color(red: 0.058824, green: 0.043137, blue: 0.070588, opacity: 1)
        public static let gray100 = Color(red: 0.105882, green: 0.070588, blue: 0.129412, opacity: 1)
        public static let gray200 = Color(red: 0.14902, green: 0.113725, blue: 0.168627, opacity: 1)
        public static let gray300 = Color(red: 0.2, green: 0.152941, blue: 0.227451, opacity: 1)
        public static let gray400 = Color(red: 0.294118, green: 0.254902, blue: 0.321569, opacity: 1)
        public static let gray500 = Color(red: 0.4, green: 0.345098, blue: 0.435294, opacity: 1)
        public static let gray600 = Color(red: 0.505882, green: 0.454902, blue: 0.541176, opacity: 1)
        public static let gray700 = Color(red: 0.615686, green: 0.568627, blue: 0.647059, opacity: 1)
        public static let gray800 = Color(red: 0.729412, green: 0.686275, blue: 0.756863, opacity: 1)
        public static let gray900 = Color(red: 0.843137, green: 0.811765, blue: 0.866667, opacity: 1)
        public static let gray950 = Color(red: 0.960784, green: 0.937255, blue: 0.976471, opacity: 1)
        public static let gray1000 = Color(red: 1, green: 1, blue: 1, opacity: 1)
    }

    public enum Lavender {
        public static let lavender0 = Color(red: 0.952941, green: 0.941176, blue: 0.984314, opacity: 1)
        public static let lavender50 = Color(red: 0.905882, green: 0.87451, blue: 0.984314, opacity: 1)
        public static let lavender100 = Color(red: 0.862745, green: 0.811765, blue: 0.984314, opacity: 1)
        public static let lavender200 = Color(red: 0.776471, green: 0.682353, blue: 0.976471, opacity: 1)
        public static let lavender300 = Color(red: 0.694118, green: 0.552941, blue: 0.94902, opacity: 1)
        public static let lavender400 = Color(red: 0.611765, green: 0.423529, blue: 0.905882, opacity: 1)
        public static let lavender500 = Color(red: 0.529412, green: 0.290196, blue: 0.847059, opacity: 1)
        public static let lavender600 = Color(red: 0.447059, green: 0.133333, blue: 0.776471, opacity: 1)
        public static let lavender700 = Color(red: 0.352941, green: 0.003922, blue: 0.639216, opacity: 1)
        public static let lavender800 = Color(red: 0.25098, green: 0.003922, blue: 0.462745, opacity: 1)
        public static let lavender900 = Color(red: 0.152941, green: 0, blue: 0.301961, opacity: 1)
        public static let lavender950 = Color(red: 0.109804, green: 0, blue: 0.227451, opacity: 1)
        public static let lavender1000 = Color(red: 0.066667, green: 0, blue: 0.152941, opacity: 1)
    }

    public enum Powder {
        public static let powder0 = Color(red: 1, green: 0.968627, blue: 0.945098, opacity: 1)
        public static let powder50 = Color(red: 1, green: 0.901961, blue: 0.839216, opacity: 1)
        public static let powder100 = Color(red: 1, green: 0.835294, blue: 0.729412, opacity: 1)
        public static let powder150 = Color(red: 0.996078, green: 0.768627, blue: 0.619608, opacity: 1)
        public static let powder200 = Color(red: 0.988235, green: 0.698039, blue: 0.509804, opacity: 1)
        public static let powder300 = Color(red: 0.94902, green: 0.568627, blue: 0.294118, opacity: 1)
        public static let powder400 = Color(red: 0.878431, green: 0.447059, blue: 0.003922, opacity: 1)
        public static let powder500 = Color(red: 0.741176, green: 0.376471, blue: 0.015686, opacity: 1)
        public static let powder600 = Color(red: 0.611765, green: 0.305882, blue: 0.011765, opacity: 1)
        public static let powder700 = Color(red: 0.490196, green: 0.239216, blue: 0.003922, opacity: 1)
        public static let powder800 = Color(red: 0.368627, green: 0.176471, blue: 0, opacity: 1)
        public static let powder900 = Color(red: 0.258824, green: 0.113725, blue: 0, opacity: 1)
        public static let powder1000 = Color(red: 0.152941, green: 0.058824, blue: 0, opacity: 1)
    }
}

public enum FunctionalColor {

    public enum Green {
        public static let green0 = Color(red: 1, green: 1, blue: 1, opacity: 1)
        public static let green50 = Color(red: 0.835294, green: 0.996078, blue: 0.835294, opacity: 1)
        public static let green100 = Color(red: 0.670588, green: 0.992157, blue: 0.670588, opacity: 1)
        public static let green200 = Color(red: 0.415686, green: 0.94902, blue: 0.415686, opacity: 1)
        public static let green300 = Color(red: 0.188235, green: 0.901961, blue: 0.188235, opacity: 1)
        public static let green400 = Color(red: 0, green: 0.858824, blue: 0, opacity: 1)
        public static let green500 = Color(red: 0, green: 0.752941, blue: 0, opacity: 1)
        public static let green600 = Color(red: 0, green: 0.65098, blue: 0, opacity: 1)
        public static let green700 = Color(red: 0, green: 0.545098, blue: 0, opacity: 1)
        public static let green800 = Color(red: 0, green: 0.439216, blue: 0, opacity: 1)
        public static let green900 = Color(red: 0, green: 0.337255, blue: 0, opacity: 1)
        public static let green1000 = Color(red: 0, green: 0.231373, blue: 0, opacity: 1)
        public static let green1100 = Color(red: 0, green: 0.12549, blue: 0, opacity: 1)
        public static let green1150 = Color(red: 0, green: 0.062745, blue: 0, opacity: 1)
        public static let green1200 = Color(red: 0, green: 0, blue: 0, opacity: 1)
    }

    public enum Amber {
        public static let amber0 = Color(red: 1, green: 1, blue: 1, opacity: 1)
        public static let amber50 = Color(red: 1, green: 0.984314, blue: 0.858824, opacity: 1)
        public static let amber100 = Color(red: 1, green: 0.964706, blue: 0.709804, opacity: 1)
        public static let amber200 = Color(red: 1, green: 0.886275, blue: 0.45098, opacity: 1)
        public static let amber300 = Color(red: 1, green: 0.815686, blue: 0.211765, opacity: 1)
        public static let amber400 = Color(red: 1, green: 0.74902, blue: 0, opacity: 1)
        public static let amber500 = Color(red: 0.878431, green: 0.658824, blue: 0, opacity: 1)
        public static let amber600 = Color(red: 0.760784, green: 0.568627, blue: 0, opacity: 1)
        public static let amber700 = Color(red: 0.639216, green: 0.478431, blue: 0, opacity: 1)
        public static let amber800 = Color(red: 0.517647, green: 0.388235, blue: 0, opacity: 1)
        public static let amber900 = Color(red: 0.4, green: 0.298039, blue: 0, opacity: 1)
        public static let amber1000 = Color(red: 0.278431, green: 0.207843, blue: 0, opacity: 1)
        public static let amber1100 = Color(red: 0.156863, green: 0.117647, blue: 0, opacity: 1)
        public static let amber1150 = Color(red: 0.078431, green: 0.058824, blue: 0, opacity: 1)
        public static let amber1200 = Color(red: 0, green: 0, blue: 0, opacity: 1)
    }

    public enum Red {
        public static let red0 = Color(red: 1, green: 1, blue: 1, opacity: 1)
        public static let red50 = Color(red: 1, green: 0.894118, blue: 0.894118, opacity: 1)
        public static let red100 = Color(red: 1, green: 0.780392, blue: 0.780392, opacity: 1)
        public static let red200 = Color(red: 1, green: 0.552941, blue: 0.552941, opacity: 1)
        public static let red300 = Color(red: 1, green: 0.345098, blue: 0.345098, opacity: 1)
        public static let red400 = Color(red: 1, green: 0.160784, blue: 0.160784, opacity: 1)
        public static let red500 = Color(red: 1, green: 0, blue: 0, opacity: 1)
        public static let red600 = Color(red: 0.862745, green: 0, blue: 0, opacity: 1)
        public static let red700 = Color(red: 0.729412, green: 0, blue: 0, opacity: 1)
        public static let red800 = Color(red: 0.592157, green: 0, blue: 0, opacity: 1)
        public static let red900 = Color(red: 0.458824, green: 0, blue: 0, opacity: 1)
        public static let red1000 = Color(red: 0.321569, green: 0, blue: 0, opacity: 1)
        public static let red1100 = Color(red: 0.188235, green: 0, blue: 0, opacity: 1)
        public static let red1150 = Color(red: 0.094118, green: 0, blue: 0, opacity: 1)
        public static let red1200 = Color(red: 0, green: 0, blue: 0, opacity: 1)
    }
}

// MARK: - Spacing & Layout Tokens

/// Raw numeric scale. Changing a value here cascades to Distance, Padding, Radius, Stroke.
public enum Units {
    public static let unitsNull: CGFloat = 0
    public static let units3xs: CGFloat = 0.5
    public static let units2xs: CGFloat = 1
    public static let unitsXs: CGFloat = 2
    public static let unitsSm: CGFloat = 4
    public static let unitsMd: CGFloat = 8
    public static let unitsXmd: CGFloat = 12
    public static let unitsLg: CGFloat = 16
    public static let unitsXl: CGFloat = 24
    public static let units2xl: CGFloat = 32
    public static let units3xl: CGFloat = 40
    public static let units4xl: CGFloat = 48
    public static let units5xl: CGFloat = 56
    public static let units6xl: CGFloat = 64
    public static let units7xl: CGFloat = 128
    public static let units8xl: CGFloat = 152
    public static let units9xl: CGFloat = 256
    public static let unitsRd: CGFloat = 100000
    public static let unitsMisc1: CGFloat = 23
}

/// Gap / layout spacing. References Units.
public enum Distance {
    public static let distNull: CGFloat = Units.unitsNull
    public static let dist2xs: CGFloat = Units.units2xs
    public static let distXs: CGFloat = Units.unitsXs
    public static let distSm: CGFloat = Units.unitsSm
    public static let distMd: CGFloat = Units.unitsMd
    public static let distLg: CGFloat = Units.unitsLg
    public static let distXl: CGFloat = Units.unitsXl
    public static let dist2xl: CGFloat = Units.units2xl
    public static let dist3xl: CGFloat = Units.units3xl
    public static let dist4xl: CGFloat = Units.units4xl
    public static let dist5xl: CGFloat = Units.units5xl
    public static let dist6xl: CGFloat = Units.units6xl
    public static let dist7xl: CGFloat = Units.units7xl
    public static let dist8xl: CGFloat = Units.units8xl
    public static let dist9xl: CGFloat = Units.units9xl
}

/// Component inset padding. References Units.
public enum Padding {
    public static let padNull: CGFloat = Units.unitsNull
    public static let pad2xs: CGFloat = Units.unitsXs
    public static let padXs: CGFloat = Units.unitsSm
    public static let padSm: CGFloat = Units.unitsMd
    public static let padMd: CGFloat = Units.unitsXmd
    public static let padLg: CGFloat = Units.unitsLg
    public static let padXl: CGFloat = Units.unitsXl
    public static let pad2xl: CGFloat = Units.units2xl
    public static let pad3xl: CGFloat = Units.units3xl
    public static let pad4xl: CGFloat = Units.units4xl
    public static let pad5xl: CGFloat = Units.units5xl
    public static let pad6xl: CGFloat = Units.units6xl
    public static let pad7xl: CGFloat = Units.units7xl
    public static let pad8xl: CGFloat = Units.units8xl
    public static let pad9xl: CGFloat = Units.units9xl
    public static let mgnDesktop: CGFloat = Units.units8xl
    public static let mgnMobile: CGFloat = Units.unitsXl
}

/// Corner radius. References Units.
public enum Radius {
    public static let radNull: CGFloat = Units.unitsNull
    public static let radXs: CGFloat = Units.unitsXs
    public static let radSm: CGFloat = Units.unitsSm
    public static let radMd: CGFloat = Units.unitsMd
    public static let radLg: CGFloat = Units.unitsLg
    public static let radXl: CGFloat = Units.unitsXl
    public static let radRd: CGFloat = Units.unitsRd
}

/// Border / stroke widths. References Units.
public enum Stroke {
    public static let strokeSm: CGFloat = Units.units3xs
    public static let strokeMd: CGFloat = Units.units2xs
    public static let strokeLg: CGFloat = Units.unitsXs
    public static let strokeXl: CGFloat = Units.unitsSm
}

// MARK: - Semantic Theme Tokens
//
// These are what your views should reference.
// Each token resolves through to a BrandColor or FunctionalColor primitive.
//
//   Text("Hi").foregroundStyle(HaloTheme.textBold)
//   .padding(Padding.padMd)
//   .cornerRadius(Radius.radSm)

public enum HaloTheme {

    // ────────────────────────────────────────────────────────────────────
    // MARK: Text
    // ────────────────────────────────────────────────────────────────────

    public static let textBold = BrandColor.Gray.gray1000
    public static let textSubtle = BrandColor.Gray.gray700
    public static let textMinimal = BrandColor.Gray.gray400
    public static let textInverse = BrandColor.Gray.gray0
    public static let textSuccess = FunctionalColor.Green.green600
    public static let textDanger = FunctionalColor.Red.red600
    public static let textWarning = FunctionalColor.Amber.amber700
    public static let textBrand = BrandColor.Lavender.lavender1000
    public static let textLink = BrandColor.Lavender.lavender1000

    // ────────────────────────────────────────────────────────────────────
    // MARK: Icon
    // ────────────────────────────────────────────────────────────────────

    public static let iconInverse = BrandColor.Gray.gray0
    public static let iconMinimal = BrandColor.Gray.gray200
    public static let iconSubtle = BrandColor.Gray.gray500
    public static let iconBold = BrandColor.Gray.gray900
    public static let iconSuccess = FunctionalColor.Green.green600
    public static let iconDanger = FunctionalColor.Red.red600
    public static let iconWarning = FunctionalColor.Amber.amber600
    public static let iconBrand = BrandColor.Lavender.lavender1000
    public static let iconLink = BrandColor.Gray.gray1000

    // ────────────────────────────────────────────────────────────────────
    // MARK: Surface
    // ────────────────────────────────────────────────────────────────────

    public static let surface4 = BrandColor.Gray.gray0
    public static let surface3 = BrandColor.Gray.gray50
    public static let surface2 = BrandColor.Gray.gray100
    public static let surface1 = BrandColor.Gray.gray200
    public static let surface0 = BrandColor.Gray.gray300
    public static let surfaceBrand = BrandColor.Lavender.lavender1000
    public static let surfaceInverse = BrandColor.Gray.gray1000
    public static let surfaceBrandLight = BrandColor.Gray.gray50
    public static let surfaceDanger = FunctionalColor.Red.red700
    public static let surfaceDangerLight = FunctionalColor.Red.red50
    public static let surfaceSuccess = FunctionalColor.Green.green600
    public static let surfaceSuccessLight = FunctionalColor.Green.green50
    public static let surfaceWarning = FunctionalColor.Amber.amber600
    public static let surfaceWarningLight = FunctionalColor.Amber.amber50

    // ────────────────────────────────────────────────────────────────────
    // MARK: Border
    // ────────────────────────────────────────────────────────────────────

    public static let borderBold = BrandColor.Gray.gray900
    public static let borderSubtle = BrandColor.Gray.gray700
    public static let borderMinimal = BrandColor.Gray.gray500
    public static let borderFocused = BrandColor.Lavender.lavender300
    public static let borderHover = BrandColor.Lavender.lavender100
    public static let borderSuccess = FunctionalColor.Green.green500
    public static let borderSuccessFocused = FunctionalColor.Green.green200
    public static let borderDanger = FunctionalColor.Red.red500
    public static let borderDangerFocused = FunctionalColor.Red.red100
    public static let borderWarning = FunctionalColor.Amber.amber500
    public static let borderWarningFocused = FunctionalColor.Amber.amber200
    public static let borderBrand = BrandColor.Lavender.lavender1000
    public static let borderInverse = BrandColor.Gray.gray0

    // ────────────────────────────────────────────────────────────────────
    // MARK: Button
    // ────────────────────────────────────────────────────────────────────

    public static let buttonBrandPrimaryRest = BrandColor.Lavender.lavender1000
    public static let buttonBrandPrimaryHover = BrandColor.Lavender.lavender800
    public static let buttonBrandPrimaryPressed = BrandColor.Lavender.lavender900
    public static let buttonBrandPrimaryFocused = BrandColor.Lavender.lavender1000
    public static let buttonBrandPrimaryDisabled = BrandColor.Gray.gray300
    public static let buttonBrandSecondaryRest = BrandColor.Lavender.lavender100
    public static let buttonBrandSecondaryHover = BrandColor.Lavender.lavender200
    public static let buttonBrandSecondaryPressed = BrandColor.Lavender.lavender400
    public static let buttonBrandSecondaryFocused = BrandColor.Lavender.lavender100
    public static let buttonBrandSecondaryDisabled = BrandColor.Gray.gray300
    public static let buttonBrandGhostHover = BrandColor.Lavender.lavender200
    public static let buttonBrandGhostPressed = BrandColor.Lavender.lavender400
    public static let buttonBrandStrokeHover = BrandColor.Lavender.lavender200
    public static let buttonBrandStrokePressed = BrandColor.Lavender.lavender400
    public static let buttonSuccessPrimaryRest = FunctionalColor.Green.green700
    public static let buttonSuccessPrimaryHover = FunctionalColor.Green.green800
    public static let buttonSuccessPrimaryPressed = FunctionalColor.Green.green900
    public static let buttonSuccessPrimaryFocused = FunctionalColor.Green.green700
    public static let buttonSuccessPrimaryDisabled = BrandColor.Gray.gray300
    public static let buttonSuccessSecondaryRest = FunctionalColor.Green.green50
    public static let buttonSuccessSecondaryHover = FunctionalColor.Green.green200
    public static let buttonSuccessSecondaryPressed = FunctionalColor.Green.green400
    public static let buttonSuccessSecondaryFocused = FunctionalColor.Green.green50
    public static let buttonSuccessSecondaryDisabled = BrandColor.Gray.gray300
    public static let buttonSuccessGhostHover = FunctionalColor.Green.green200
    public static let buttonSuccessGhostPressed = FunctionalColor.Green.green400
    public static let buttonSuccessStrokeHover = FunctionalColor.Green.green200
    public static let buttonSuccessStrokePressed = FunctionalColor.Green.green400
    public static let buttonDangerPrimaryRest = FunctionalColor.Red.red600
    public static let buttonDangerPrimaryHover = FunctionalColor.Red.red800
    public static let buttonDangerPrimaryPressed = FunctionalColor.Red.red900
    public static let buttonDangerPrimaryFocused = FunctionalColor.Red.red600
    public static let buttonDangerPrimaryDisabled = BrandColor.Gray.gray300
    public static let buttonDangerSecondaryRest = FunctionalColor.Red.red50
    public static let buttonDangerSecondaryHover = FunctionalColor.Red.red200
    public static let buttonDangerSecondaryPressed = FunctionalColor.Red.red400
    public static let buttonDangerSecondaryFocused = FunctionalColor.Red.red50
    public static let buttonDangerSecondaryDisabled = BrandColor.Gray.gray300
    public static let buttonDangerGhostHover = FunctionalColor.Red.red200
    public static let buttonDangerGhostPressed = FunctionalColor.Red.red400
    public static let buttonDangerStrokeHover = FunctionalColor.Red.red200
    public static let buttonDangerStrokePressed = FunctionalColor.Red.red400
    public static let buttonWarningPrimaryRest = FunctionalColor.Amber.amber700
    public static let buttonWarningPrimaryHover = FunctionalColor.Amber.amber800
    public static let buttonWarningPrimaryPressed = FunctionalColor.Amber.amber900
    public static let buttonWarningPrimaryFocused = FunctionalColor.Amber.amber700
    public static let buttonWarningPrimaryDisabled = BrandColor.Gray.gray300
    public static let buttonWarningSecondaryRest = FunctionalColor.Amber.amber100
    public static let buttonWarningSecondaryHover = FunctionalColor.Amber.amber200
    public static let buttonWarningSecondaryPressed = FunctionalColor.Amber.amber400
    public static let buttonWarningSecondaryFocused = FunctionalColor.Amber.amber100
    public static let buttonWarningSecondaryDisabled = BrandColor.Gray.gray300
    public static let buttonWarningGhostHover = FunctionalColor.Amber.amber200
    public static let buttonWarningGhostPressed = FunctionalColor.Amber.amber400
    public static let buttonWarningStrokeHover = FunctionalColor.Amber.amber200
    public static let buttonWarningStrokePressed = FunctionalColor.Amber.amber400

    // ────────────────────────────────────────────────────────────────────
    // MARK: Badge
    // ────────────────────────────────────────────────────────────────────

    public static let badgeBrandPrimary = BrandColor.Lavender.lavender1000
    public static let badgeBrandSecondary = BrandColor.Lavender.lavender50
    public static let badgeGrayPrimary = BrandColor.Gray.gray1000
    public static let badgeGraySecondary = BrandColor.Gray.gray50
    public static let badgeGreenPrimary = FunctionalColor.Green.green700
    public static let badgeGreenSecondary = FunctionalColor.Green.green50
    public static let badgeRedPrimary = FunctionalColor.Red.red600
    public static let badgeRedSecondary = FunctionalColor.Red.red50
    public static let badgeAmberPrimary = FunctionalColor.Amber.amber600
    public static let badgeAmberSecondary = FunctionalColor.Amber.amber100

    // ────────────────────────────────────────────────────────────────────
    // MARK: Indicator
    // ────────────────────────────────────────────────────────────────────

    public static let indicatorBrandPrimary = BrandColor.Lavender.lavender1000
    public static let indicatorBrandSecondary = BrandColor.Lavender.lavender50
    public static let indicatorGrayPrimary = BrandColor.Gray.gray1000
    public static let indicatorGraySecondary = BrandColor.Gray.gray50
    public static let indicatorGreenPrimary = FunctionalColor.Green.green600
    public static let indicatorGreenSecondary = FunctionalColor.Green.green50
    public static let indicatorRedPrimary = FunctionalColor.Red.red600
    public static let indicatorRedSecondary = FunctionalColor.Red.red50
    public static let indicatorAmberPrimary = FunctionalColor.Amber.amber500
    public static let indicatorAmberSecondary = FunctionalColor.Amber.amber100

    // ────────────────────────────────────────────────────────────────────
    // MARK: TextInput
    // ────────────────────────────────────────────────────────────────────

    public static let textInputSurfaceRest = BrandColor.Gray.gray200
    public static let textInputSurfaceHover = BrandColor.Gray.gray300

    // ────────────────────────────────────────────────────────────────────
    // MARK: Toggle
    // ────────────────────────────────────────────────────────────────────

    public static let toggleKnobRest = BrandColor.Gray.gray0
    public static let toggleKnobDisabled = BrandColor.Gray.gray400
    public static let toggleSurfaceChecked = BrandColor.Lavender.lavender1000
    public static let toggleSurfaceUnchecked = BrandColor.Gray.gray200
    public static let toggleSurfaceUncheckedDisabled = BrandColor.Gray.gray100
    public static let toggleSurfaceCheckedDisabled = BrandColor.Gray.gray200

    // ────────────────────────────────────────────────────────────────────
    // MARK: List
    // ────────────────────────────────────────────────────────────────────

    public static let listSurfaceRest = BrandColor.Gray.gray0
    public static let listSurfaceHover = BrandColor.Gray.gray50
    public static let listSurfacePressed = BrandColor.Gray.gray100

    // ────────────────────────────────────────────────────────────────────
    // MARK: Date
    // ────────────────────────────────────────────────────────────────────

    public static let dateCalendarItemSurfaceRest = BrandColor.Gray.gray0
    public static let dateCalendarItemSurfaceHover = BrandColor.Lavender.lavender50
    public static let dateCalendarItemSurfaceRange = BrandColor.Lavender.lavender100
    public static let dateCalendarItemSurfaceSelected = BrandColor.Lavender.lavender1000

    // ────────────────────────────────────────────────────────────────────
    // MARK: Menu
    // ────────────────────────────────────────────────────────────────────

    public static let menuSurfaceRest = BrandColor.Gray.gray0
    public static let menuSurfaceHover = BrandColor.Gray.gray50
    public static let menuSurfacePressed = BrandColor.Gray.gray100

    // ────────────────────────────────────────────────────────────────────
    // MARK: Table
    // ────────────────────────────────────────────────────────────────────

    public static let tableSurfaceCellRest = BrandColor.Gray.gray0
    public static let tableSurfaceCellHover = BrandColor.Gray.gray50
    public static let tableSurfaceCellSelected = BrandColor.Lavender.lavender1000
    public static let tableSurfaceHeaderRest = BrandColor.Gray.gray50
    public static let tableSurfaceHeaderHover = BrandColor.Gray.gray100
    public static let tableSurfaceHeaderSelected = BrandColor.Lavender.lavender1000

}
