import UIKit

extension UIColor {
    private static func color(named name: String, fallback: UIColor) -> UIColor {
        UIColor(named: name) ?? fallback
    }

    // MARK: - Purple
    static let aetherPurple900 = color(named: "Purple900", fallback: .init(red: 0x1E/255, green: 0x0A/255, blue: 0x4A/255, alpha: 1))
    static let aetherPurple700 = color(named: "Purple700", fallback: .init(red: 0x5B/255, green: 0x21/255, blue: 0xB6/255, alpha: 1))
    static let aetherPurple500 = color(named: "Purple500", fallback: .init(red: 0x7C/255, green: 0x3A/255, blue: 0xED/255, alpha: 1))
    static let aetherPurple300 = color(named: "Purple300", fallback: .init(red: 0xC4/255, green: 0xB5/255, blue: 0xFD/255, alpha: 1))
    static let aetherPurple100 = color(named: "Purple100", fallback: .init(red: 0xED/255, green: 0xE9/255, blue: 0xFE/255, alpha: 1))

    // MARK: - Green
    static let aetherGreen900 = color(named: "Green900", fallback: .init(red: 0x0D/255, green: 0x3B/255, blue: 0x35/255, alpha: 1))
    static let aetherGreen700 = color(named: "Green700", fallback: .init(red: 0x1A/255, green: 0x5C/255, blue: 0x4A/255, alpha: 1))
    static let aetherGreen500 = color(named: "Green500", fallback: .init(red: 0x2D/255, green: 0xBD/255, blue: 0x7E/255, alpha: 1))
    static let aetherGreen300 = color(named: "Green300", fallback: .init(red: 0x5D/255, green: 0xDB/255, blue: 0xA5/255, alpha: 1))
    static let aetherGreen100 = color(named: "Green100", fallback: .init(red: 0xA8/255, green: 0xF0/255, blue: 0xD2/255, alpha: 1))

    // MARK: - Text (adaptive light/dark)
    static let aetherTextPrimary = color(named: "TextPrimary", fallback: .label)
    static let aetherTextSecondary = color(named: "TextSecondary", fallback: .secondaryLabel)
    static let aetherTextTertiary = color(named: "TextTertiary", fallback: .tertiaryLabel)
    static let aetherTextDisabled = color(named: "TextDisabled", fallback: .systemGray3)

    // MARK: - Backgrounds (adaptive light/dark)
    static let aetherBackground = color(named: "Background", fallback: .systemBackground)
    static let aetherBackgroundElevated = color(named: "BackgroundElevated", fallback: .secondarySystemBackground)

    // MARK: - Semantic
    static let aetherError = color(named: "Error", fallback: .systemRed)
    static let aetherWarning = color(named: "Warning", fallback: .systemOrange)
}
