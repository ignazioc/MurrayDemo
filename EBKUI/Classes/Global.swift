//
//  Global.swift
//  EBKUI
//
//  Created by Calo, Ignazio on 24.04.19.
//

import Foundation
extension Bundle {
    // This code is also on Global.m for retro-compatibilities reasons
    static func EBKUIBundleForImages() -> Bundle {
        let bundle = Bundle(for: EBKBaseButton.self)
        let subBundleURL = bundle.url(forResource: "Images", withExtension: "bundle")!
        let subBundle = Bundle(url: subBundleURL)!
        return subBundle
    }
    static func EBKUIBundleForXib() -> Bundle {
        let bundle = Bundle(for: EBKBaseButton.self)
        return bundle
    }
}
