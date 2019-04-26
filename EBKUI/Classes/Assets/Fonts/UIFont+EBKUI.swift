//
//  UIFont+EBKUI.swift
//  eBay Kleinanzeigen
//
//  Created by Calo, Ignazio on 5/12/18.
//  Copyright © 2018 eBay Kleinanzeigen. All rights reserved.
//

import UIKit
// OBJC_DEBT: This extension is only used from Obj-c classes.
// The swift code can access directly to EBKFont
@objc public enum EBKFontType: Int {
    case extraTiny,
    tiny,
    tinySemibold,
    tinyBold,
    small,
    smallBold,
    smallSemibold,
    normal,
    normalSemibold,
    normalBold,
    navigationBar,
    navigationBarSemiBold,
    navigationBarBold,
    large,
    largeBold,
    largeSemibold,
    hugeSemibold
}

public extension UIFont {
     @objc static func ebk_font(_ type: EBKFontType) -> UIFont {
        switch type {
        case .extraTiny:
            return EBKFont.standard.of(size: .extraTiny)
        case .tiny:
            return EBKFont.standard.of(size: .tiny)
        case .tinySemibold:
            return EBKFont.semibold.of(size: .tiny)
        case .tinyBold:
            return EBKFont.bold.of(size: .tiny)
        case .small:
            return EBKFont.standard.of(size: .small)
        case .smallBold:
            return EBKFont.bold.of(size: .small)
        case .smallSemibold:
            return EBKFont.semibold.of(size: .small)
        case .normal:
            return EBKFont.standard.of(size: .normal)
        case .normalSemibold:
            return EBKFont.semibold.of(size: .normal)
        case .normalBold:
            return EBKFont.bold.of(size: .normal)
        case .navigationBar:
            return EBKFont.standard.of(size: .medium)
        case .navigationBarSemiBold:
            return EBKFont.semibold.of(size: .medium)
        case .navigationBarBold:
            return EBKFont.bold.of(size: .medium)
        case .large:
            return EBKFont.standard.of(size: .large)
        case .largeBold:
            return EBKFont.bold.of(size: .large)
        case .largeSemibold:
            return EBKFont.semibold.of(size: .large)
        case .hugeSemibold:
            return EBKFont.semibold.of(size: .huge)
        }
    }

    @objc func ebk_sizeOf(_ string: String?, constrainedToWidth width: CGFloat) -> CGSize {
        return string?.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self], context: nil).size ?? CGSize.zero
    }

}
