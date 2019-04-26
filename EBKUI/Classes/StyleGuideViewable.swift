//
//  StyleGuideViewable.swift
//  EBKUI
//
//  Created by Calo, Ignazio on 5/11/18.
//  Copyright © 2018 eBay Kleinanzeigen. All rights reserved.
//

import Foundation

public protocol StyleGuideViewable {
    static var styleName: String { get }
    var itemName: String { get }
    var rawValue: String { get }
    var example: UIView { get }
}

extension StyleGuideViewable {
    public static var styleName: String {
        return "\(Self.self)".camelCaseToSpacing()
    }

    public var itemName: String {
        return self.rawValue.camelCaseToSpacing()
    }
}
