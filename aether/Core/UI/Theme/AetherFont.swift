import UIKit

enum AetherFont {
    // MARK: - Font Names
    static let black = "DMSans-Black"
    static let bold = "DMSans-Bold"
    static let extraBold = "DMSans-ExtraBold"
    static let extraBoldItalic = "DMSans-ExtraBoldItalic"
    static let extraLight = "DMSans-ExtraLight"
    static let light = "DMSans-Light"
    static let medium = "DMSans-Medium"
    static let regular = "DMSans-Regular"
    static let semiBold = "DMSans-SemiBold"
    static let thin = "DMSans-Thin"

    // MARK: - Styles
    static func displayLarge(weight: Weight = .bold) -> UIFont {
        .custom(name: fontName(for: weight), size: 52)
    }

    static func displayMedium(weight: Weight = .bold) -> UIFont {
        .custom(name: fontName(for: weight), size: 36)
    }

    static func titleLarge(weight: Weight = .semiBold) -> UIFont {
        .custom(name: fontName(for: weight), size: 24)
    }

    static func titleMedium(weight: Weight = .semiBold) -> UIFont {
        .custom(name: fontName(for: weight), size: 17)
    }

    static func titleSmall(weight: Weight = .regular) -> UIFont {
        .custom(name: fontName(for: weight), size: 16)
    }

    static func bodyLarge(weight: Weight = .regular) -> UIFont {
        .custom(name: fontName(for: weight), size: 16)
    }

    static func bodyMedium(weight: Weight = .regular) -> UIFont {
        .custom(name: fontName(for: weight), size: 14)
    }

    static func bodySmall(weight: Weight = .regular) -> UIFont {
        .custom(name: fontName(for: weight), size: 12)
    }

    static func labelLarge(weight: Weight = .medium) -> UIFont {
        .custom(name: fontName(for: weight), size: 15)
    }

    static func labelMedium(weight: Weight = .medium) -> UIFont {
        .custom(name: fontName(for: weight), size: 13)
    }

    static func labelSmall(weight: Weight = .medium) -> UIFont {
        .custom(name: fontName(for: weight), size: 11)
    }

    // MARK: - Weight Mapping
    enum Weight: String, CaseIterable {
        case thin
        case extraLight
        case light
        case regular
        case medium
        case semiBold
        case bold
        case extraBold
        case black

        var name: String {
            switch self {
            case .thin: return AetherFont.thin
            case .extraLight: return AetherFont.extraLight
            case .light: return AetherFont.light
            case .regular: return AetherFont.regular
            case .medium: return AetherFont.medium
            case .semiBold: return AetherFont.semiBold
            case .bold: return AetherFont.bold
            case .extraBold: return AetherFont.extraBold
            case .black: return AetherFont.black
            }
        }
    }

    private static func fontName(for weight: Weight) -> String {
        weight.name
    }
}

private extension UIFont {
    static func custom(name: String, size: CGFloat) -> UIFont {
        UIFont(name: name, size: size) ?? .systemFont(ofSize: size)
    }
}
