import UIKit
import CoreText

enum FontRegistration {
    static func registerCustomFonts() {
        let fontNames = [
            "dmsans_black.ttf",
            "dmsans_bold.ttf",
            "dmsans_extrabold.ttf",
            "dmsans_extrabolditalic.ttf",
            "dmsans_extralight.ttf",
            "dmsans_light.ttf",
            "dmsans_medium.ttf",
            "dmsans_regular.ttf",
            "dmsans_semibold.ttf",
            "dmsans_thin.ttf"
        ]

        for fontName in fontNames {
            registerFont(named: fontName)
        }
    }

    private static func registerFont(named fileName: String) {
        guard let fontURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("Font file not found: \(fileName)")
            return
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, .persistent, &error)

        if let error = error?.takeRetainedValue() {
            let errorDescription = CFErrorCopyDescription(error) as String
            print("Failed to register font \(fileName): \(errorDescription)")
        }
    }
}
