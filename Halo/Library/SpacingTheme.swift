// =============================================================================
// Auto-generated from Figma variables — do not edit manually.
//
// Alias chain is preserved in Swift:
//   Radius.radMd        →  Units.unitsMd              →  8
//
// Editing a Units value cascades through Radius/Distance/Padding,
// =============================================================================

import SwiftUI
import Foundation

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
