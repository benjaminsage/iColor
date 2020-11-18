import SwiftUI

public extension Color {
    
    static let neonRed:        Color = Color(hue: 0/360,   saturation: 0.65, brightness: 1.00)
    static let lightRed:       Color = Color(hue: 0,       saturation: 0.30, brightness: 1.00)
    static let darkRed:        Color = Color(hue: 0,       saturation: 0.70, brightness: 0.35)
    static let neonOrange:     Color = Color(hue: 30/360,  saturation: 0.65, brightness: 1.00)
    static let lightOrange:    Color = Color(hue: 30/360,  saturation: 0.30, brightness: 1.00)
    static let darkOrange:     Color = Color(hue: 30/360,  saturation: 0.70, brightness: 0.35)
    static let neonYellow:     Color = Color(hue: 60/360,  saturation: 0.65, brightness: 1.00)
    static let lightYellow:    Color = Color(hue: 60/360,  saturation: 0.30, brightness: 1.00)
    static let darkYellow:     Color = Color(hue: 60/360,  saturation: 0.70, brightness: 0.35)
    static let neonGreen:      Color = Color(hue: 155/360, saturation: 0.55, brightness: 1.00)
    static let lightGreen:     Color = Color(hue: 155/360, saturation: 0.30, brightness: 1.00)
    static let darkGreen:      Color = Color(hue: 155/360, saturation: 0.70, brightness: 0.35)
    static let neonOceanBlue:  Color = Color(hue: 190/360, saturation: 0.65, brightness: 1.00)
    static let lightOceanBlue: Color = Color(hue: 190/360, saturation: 0.30, brightness: 1.00)
    static let darkOceanBlue:  Color = Color(hue: 190/360, saturation: 0.70, brightness: 0.35)
    static let neonBlue:       Color = Color(hue: 205/360, saturation: 0.65, brightness: 1.00)
    static let lightBlue:      Color = Color(hue: 205/360, saturation: 0.30, brightness: 1.00)
    static let darkBlue:       Color = Color(hue: 205/360, saturation: 0.70, brightness: 0.35)
    static let neonPurple:     Color = Color(hue: 240/360, saturation: 0.65, brightness: 1.00)
    static let lightPurple:    Color = Color(hue: 240/360, saturation: 0.30, brightness: 1.00)
    static let darkPurple:     Color = Color(hue: 240/360, saturation: 0.70, brightness: 0.35)
    static let neonPink:       Color = Color(hue: 335/360, saturation: 0.65, brightness: 1.00)
    static let lightPink:      Color = Color(hue: 335/360, saturation: 0.30, brightness: 1.00)
    static let darkPink:       Color = Color(hue: 335/360, saturation: 0.70, brightness: 0.35)
    static let lightGray:      Color = Color(hue: 0,       saturation: 0,    brightness: 0.80)
    static let mediumgray:     Color = Color(hue: 0,       saturation: 0,    brightness: 0.60)
    static let darkGray:       Color = Color(hue: 0,       saturation: 0,    brightness: 0.25)
    
    private static let rgbRange: ClosedRange<Int> = 0...255
    private static let alphaRange: ClosedRange<Int> = 0...100
    
    /// Creates a new `Color` 🎨 object from a hex value (e. g. "#18B5DF"), represented as a `String`.
    /// - Parameters:
    ///   - hex: A hex value, not case sensitive, represented as a `String`
    ///   - opacity: The opacity of the color to be constructed
    init?(_ hex: String, opacity: Double = 1.0) {
        var hexFormatted: String =
            hex
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                .uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        if hexFormatted.count != 6 { return nil }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: Double(((rgbValue & 0xFF0000) >> 16) / 255),
                  green: Double((rgbValue & 0x0000FF) / 255),
                  blue: Double(((rgbValue & 0x00FF00) >> 8) / 255),
                  opacity: opacity)
    }
    
    /// Creates a new `Color` object from a hex value, represented as a `String`.
    /// - Parameters:
    ///   - hex: A hex value, not case sensitive, represented as a `String`
    ///   - opacity: The opacity of the color 🏳🏴
    init?(_ hex: String, opacity: Int = 100) {
        self.init(hex, opacity: Double(opacity / 100))
    }
    
    /// Creates a new `Color` object from RGB values ranging from 0 to 255.
    /// - Parameters:
    ///   - colorSpace: The color space of the color
    ///   - red: The color's **red** component, ranging from 0 to 255.
    ///   - green: The color's **green** component, ranging from 0 to 255.
    ///   - blue: The color's **blue** component, ranging from 0 to 255
    ///   - opacity: The color's **opacity**, ranging from 0 to 100.
    init(_ colorSpace: Self.RGBColorSpace = .sRGB,
                red: Int, green: Int, blue: Int, opacity: Int = 100)
    {
        self.init(colorSpace,
                  red: Double(red.clamp(to: Self.rgbRange) / 255),
                  green: Double(green.clamp(to: Self.rgbRange) / 255),
                  blue: Double(blue.clamp(to: Self.rgbRange) / 255),
                  opacity: Double(opacity.clamp(to: Self.alphaRange) / 100))
    }
}

fileprivate extension Comparable {
    func clamp<T: Comparable>(_ lower: T, _ upper: T) -> T {
        let castSelf = self as! T
        if castSelf < lower {
            return lower
        } else if castSelf > upper {
            return upper
        }
        return castSelf
    }
    
    func clamp<T: Comparable>(to range: Range<T>) -> T {
        return self.clamp(range.lowerBound, range.upperBound)
    }
    
    func clamp<T: Comparable>(to range: ClosedRange<T>) -> T {
        return self.clamp(range.lowerBound, range.upperBound)
    }
}
