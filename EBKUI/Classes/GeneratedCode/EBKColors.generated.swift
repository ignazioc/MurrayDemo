// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// MARK: - Colors

internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#202020"></span>
  /// Alpha: 100% <br/> (0x202020ff)
  internal static let ebkBlack = ColorName(rgbaValue: 0x202020ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0062d4"></span>
  /// Alpha: 100% <br/> (0x0062d4ff)
  internal static let ebkBlue = ColorName(rgbaValue: 0x0062d4ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9b9b9b"></span>
  /// Alpha: 100% <br/> (0x9b9b9bff)
  internal static let ebkDarkGray = ColorName(rgbaValue: 0x9b9b9bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#508200"></span>
  /// Alpha: 100% <br/> (0x508200ff)
  internal static let ebkDarkGreen = ColorName(rgbaValue: 0x508200ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#508200"></span>
  /// Alpha: 100% <br/> (0x508200ff)
  internal static let ebkFilterDarkGreen = ColorName(rgbaValue: 0x508200ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#76a811"></span>
  /// Alpha: 100% <br/> (0x76a811ff)
  internal static let ebkFilterLightGreen = ColorName(rgbaValue: 0x76a811ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#cbcbcb"></span>
  /// Alpha: 100% <br/> (0xcbcbcbff)
  internal static let ebkGray = ColorName(rgbaValue: 0xcbcbcbff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#87b919"></span>
  /// Alpha: 100% <br/> (0x87b919ff)
  internal static let ebkGreen = ColorName(rgbaValue: 0x87b919ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f2f2f2"></span>
  /// Alpha: 100% <br/> (0xf2f2f2ff)
  internal static let ebkLightGray = ColorName(rgbaValue: 0xf2f2f2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9fc747"></span>
  /// Alpha: 100% <br/> (0x9fc747ff)
  internal static let ebkLightGreen = ColorName(rgbaValue: 0x9fc747ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f8adae"></span>
  /// Alpha: 100% <br/> (0xf8adaeff)
  internal static let ebkLightRed = ColorName(rgbaValue: 0xf8adaeff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fff3d5"></span>
  /// Alpha: 100% <br/> (0xfff3d5ff)
  internal static let ebkLightYellow = ColorName(rgbaValue: 0xfff3d5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ed6d00"></span>
  /// Alpha: 100% <br/> (0xed6d00ff)
  internal static let ebkOrange = ColorName(rgbaValue: 0xed6d00ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e53238"></span>
  /// Alpha: 100% <br/> (0xe53238ff)
  internal static let ebkRed = ColorName(rgbaValue: 0xe53238ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#8e8e93"></span>
  /// Alpha: 100% <br/> (0x8e8e93ff)
  internal static let ebkSearchBarGray = ColorName(rgbaValue: 0x8e8e93ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let ebkWhite = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5af02"></span>
  /// Alpha: 100% <br/> (0xf5af02ff)
  internal static let ebkYellow = ColorName(rgbaValue: 0xf5af02ff)
}

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
