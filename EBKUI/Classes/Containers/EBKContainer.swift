//
//  EBKContainer.swift
//  EBKUI
//
//  Created by Calo, Ignazio on 5/12/18.
//  Copyright © 2018 eBay Kleinanzeigen. All rights reserved.
//

import UIKit

public enum EBKContainerStyle: String {
    case withShadow, sample

    var backgroundColor: UIColor {
        switch self {
        case .withShadow, .sample:
            return UIColor.ebkWhite
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .withShadow, .sample:
            return 3
        }
    }

    var shadowColor: CGColor {
        switch self {
        case .withShadow, .sample:
            return UIColor.black.cgColor
        }
    }

    var shadowOffset: CGSize {
        switch self {
        case .withShadow, .sample:
            return CGSize(width: 0, height: 1)
        }
    }

    var shadowOpacity: Float {
        switch self {
        case .withShadow, .sample:
            return 0.5
        }
    }

    var shadowRadius: CGFloat {
        switch self {
        case .withShadow, .sample:
            return 1
        }
    }

    var clipsToBounds: Bool {
        switch self {
        case .withShadow, .sample:
            return false
        }
    }
}

extension EBKContainerStyle: StyleGuideViewable {
    public var example: UIView {
        let view = EBKBaseContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red

        [view.heightAnchor.constraint(equalToConstant: 100),
         view.widthAnchor.constraint(equalToConstant: 300)].forEach {
            $0.priority = .defaultLow
            $0.isActive = true
        }
        view.containerStyle = self
        return view
    }
}

@IBDesignable
public class EBKBaseContainer: UIView {
    var containerStyle: EBKContainerStyle! {
        didSet {
            backgroundColor = containerStyle.backgroundColor
            clipsToBounds = containerStyle.clipsToBounds
            layer.cornerRadius = containerStyle.cornerRadius
            layer.shadowColor = containerStyle.shadowColor
            layer.shadowOffset = containerStyle.shadowOffset
            layer.shadowOpacity = containerStyle.shadowOpacity
            layer.shadowRadius = containerStyle.shadowRadius
        }
    }

    func commonSetup() {
        // Code here will be executed in all setup states
    }

    convenience init() {
        self.init(frame: .zero)
        self.commonSetup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.commonSetup()
    }
}

public class EBKContainerWithShadow: EBKBaseContainer {
    override func commonSetup() {
        self.containerStyle = .withShadow
    }
}
