import SwiftUI

// MARK: - NOOP visual foundation (colorful-card aesthetic)
//
// Soft off-white canvases, highly rounded white cards, pastel accent washes, and subtle elevation.
// Screens keep their hierarchy and data bindings; cards, gauges, typography, and chrome share
// these tokens.

public enum NoopVisualStyle {
    // Light: warm off-white field; dark: soft charcoal (not pure black).
    public static let canvas = Color(light: "#F6F5F2", dark: "#1E1F24")
    public static let surface = Color(light: "#FFFFFF", dark: "#2E3038")
    public static let surfaceTop = Color(light: "#FFFFFF", dark: "#33353E")
    public static let surfaceBottom = Color(light: "#FAFAF8", dark: "#2A2C34")
    public static let inset = Color(light: "#EEECE8", dark: "#25272E")

    public static let border = Color(light: "#E8E6E1", dark: "#3A3D48")
    public static let borderHighlight = Color(light: "#FFFFFF", dark: "#4A4E5A")
    public static let divider = Color(light: "#ECEAE5", dark: "#353840")

    public static let primaryText = Color(light: "#141518", dark: "#F7F7FA")
    public static let secondaryText = Color(light: "#5C6068", dark: "#C3C4CA")
    public static let tertiaryText = Color(light: "#8A8E98", dark: "#7D7F88")

    public static let mint = Color(light: "#149A78", dark: "#69DDB8")
    public static let mintDeep = Color(light: "#0D765C", dark: "#13A982")
    public static let mintGlow = Color(light: "#38C99E", dark: "#54E6BD")

    /// Pastel card accents (mockup-inspired; use for filled metric/challenge tiles).
    public static let pastelSky = Color(light: "#D6EBFF", dark: "#1E3A5F")
    public static let pastelMint = Color(light: "#D4F5E8", dark: "#1A4034")
    public static let pastelPeach = Color(light: "#FFE4D6", dark: "#4A3028")
    public static let pastelCoral = Color(light: "#FFD6CC", dark: "#4A2824")
    public static let pastelSoftOrange = Color(light: "#FFE8CC", dark: "#4A3820")

    public static let cardRadius: CGFloat = 28
    public static let compactRadius: CGFloat = 20
    public static let pillRadius: CGFloat = 999
    public static let pagePadding: CGFloat = 16
    public static let cardPadding: CGFloat = 16
    public static let itemGap: CGFloat = 12
    public static let sectionGap: CGFloat = 26
}

/// Shared card/panel treatment: white cards with pastel washes, soft hairlines, and gentle elevation.
public struct NoopPanelSurface: View {
    public var tint: Color?
    public var cornerRadius: CGFloat
    public var elevated: Bool
    public var surfaceOpacity: Double
    @Environment(\.colorScheme) private var scheme

    public init(
        tint: Color? = nil,
        cornerRadius: CGFloat = NoopVisualStyle.cardRadius,
        elevated: Bool = false,
        surfaceOpacity: Double = 1
    ) {
        self.tint = tint
        self.cornerRadius = cornerRadius
        self.elevated = elevated
        self.surfaceOpacity = surfaceOpacity
    }

    public var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        let light = scheme == .light
        let shadowOpacity = light ? (elevated ? 0.14 : 0.08) : (elevated ? 0.34 : 0.16)
        let shadowRadius: CGFloat = light ? (elevated ? 20 : 12) : (elevated ? 18 : 9)
        let shadowY: CGFloat = light ? (elevated ? 8 : 4) : (elevated ? 10 : 5)

        shape
            .fill(
                LinearGradient(
                    colors: [NoopVisualStyle.surfaceTop, NoopVisualStyle.surfaceBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay {
                if let tint {
                    shape.fill(tint.opacity(light ? 0.28 : 0.14))
                    shape.fill(
                        LinearGradient(
                            colors: [
                                NoopVisualStyle.surface.opacity(light ? 0.62 : 0.78),
                                NoopVisualStyle.surface.opacity(light ? 0.72 : 0.85),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    shape.fill(
                        LinearGradient(
                            colors: [tint.opacity(0.10), tint.opacity(0.02), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                }
            }
            .overlay(
                shape.strokeBorder(
                    light
                        ? NoopVisualStyle.border.opacity(elevated ? 0.95 : 0.75)
                        : NoopVisualStyle.borderHighlight.opacity(0.55),
                    lineWidth: 0.8
                )
            )
            .shadow(
                color: Color(hex: "#1A2230").opacity(shadowOpacity),
                radius: shadowRadius,
                x: 0,
                y: shadowY
            )
            .opacity(surfaceOpacity)
    }
}

/// Shared edge-to-edge chrome for sheet and split-view headers.
public struct NoopChromeSurface: View {
    public init() {}

    public var body: some View {
        LinearGradient(
            colors: [NoopVisualStyle.surfaceTop, NoopVisualStyle.surfaceBottom],
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(NoopVisualStyle.divider)
                .frame(height: 0.5)
        }
    }
}

public extension View {
    func noopPanel(
        tint: Color? = nil,
        cornerRadius: CGFloat = NoopVisualStyle.cardRadius,
        elevated: Bool = false,
        surfaceOpacity: Double = 1
    ) -> some View {
        background {
            NoopPanelSurface(
                tint: tint,
                cornerRadius: cornerRadius,
                elevated: elevated,
                surfaceOpacity: surfaceOpacity
            )
        }
    }
}
