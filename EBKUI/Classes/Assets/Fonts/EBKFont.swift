//
//  EBKFont.swift
//  EBKUI
//
//  Created by Calo, Ignazio on 5/12/18.
//  Copyright © 2018 eBay Kleinanzeigen. All rights reserved.
//

import Foundation
import UIKit

public enum EBKFont: String {
    case
    standard,
    semibold,
    bold,
    boldItalic

    public func of(size: EBKFontSize) -> UIFont {
        switch self {
        case .standard:
            return UIFont.systemFont(ofSize: size.value)
        case .semibold:
            return UIFont.systemFont(ofSize: size.value, weight: .semibold)
        case .bold:
            return UIFont.boldSystemFont(ofSize: size.value)
        case .boldItalic:
            let font = UIFont.systemFont(ofSize: size.value)
            guard let descriptor = font.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) else {
                return font
            }
            return UIFont(descriptor: descriptor, size: size.value)
        }
    }
}

extension EBKFont: StyleGuideViewable {
    public var example: UIView {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = self.of(size: .normal)
        label.text = label.font.fontName
        return label
    }
}

public enum EBKFontSize: String {
    case
    extraTiny,
    tiny,
    mini,
    small,
    normal,
    medium,
    large,
    huge

    var value: CGFloat {
        let bigScreenAdjust: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ? 2.0 : 0
        switch self {

        case .extraTiny:
            return 8.0 + bigScreenAdjust
        case .tiny:
            return 10.0 + bigScreenAdjust
        case .mini:
            return 11.0 + bigScreenAdjust
        case .small:
            return 12.0 + bigScreenAdjust
        case .normal:
            return 14.0 + bigScreenAdjust
        case .medium:
            return 16.0 + bigScreenAdjust
        case .large:
            return 18.0 + bigScreenAdjust
        case .huge:
            return 20.0 + bigScreenAdjust

        }
    }
}

extension EBKFontSize: StyleGuideViewable {

    public var example: UIView {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: self.value)
        label.text = "\(self.value) pt"
        return label
    }
}
