//
//  EBKButtons.swift
//  EBKUI
//
//  Created by Calo, Ignazio on 6/10/18.
//  Copyright © 2018 eBay Kleinanzeigen. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }

            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }

    @IBInspectable var adjustsFontSizeToFitWidth: Bool {
        set {
            titleLabel?.adjustsFontSizeToFitWidth = newValue
        }
        get {
            return titleLabel?.adjustsFontSizeToFitWidth ?? false
        }
    }
}

public enum EBKButtonStyle: String {
    case autograyout, message, withChevron, contactUs, standardGreen, treeBay, greenBorder

    var borderColor: UIColor {
        switch self {
        case .autograyout, .message, .withChevron, .contactUs, .standardGreen, .treeBay:
            return UIColor.clear
        case .greenBorder:
            return UIColor.ebkGreen
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .withChevron, .message, .autograyout:
            return 0
        case .standardGreen, .treeBay, .contactUs, .greenBorder:
            return 5.0
        }
    }

    var titleColor: UIColor {
        switch self {
        case .withChevron, .message, .greenBorder:
            return UIColor.ebkGreen
        case .autograyout, .standardGreen, .treeBay, .contactUs:
            return UIColor.ebkWhite
        }
    }

    var titleFont: UIFont {
        switch self {
        case .withChevron, .autograyout, .message, .greenBorder:
            return EBKFont.standard.of(size: .medium)
        case .standardGreen, .contactUs, .treeBay:
            return EBKFont.standard.of(size: .normal)
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .autograyout, .message, .withChevron, .greenBorder:
            return UIColor.clear
        case .contactUs:
            return UIColor.ebkDarkGray
        case .standardGreen:
            return UIColor.ebkGreen
        case .treeBay:
            return UIColor.ebkBlue
        }
    }

    var tintColor: UIColor {
        switch self {
        case .withChevron, .greenBorder:
            return UIColor.ebkGreen
        case .autograyout, .message, .contactUs, .standardGreen, .treeBay:
            return UIColor.ebkWhite
        }
    }
}

extension EBKButtonStyle: StyleGuideViewable {
    public var example: UIView {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        let heigthConstraint = stackView.heightAnchor.constraint(equalToConstant: 80)
        heigthConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 300),
            heigthConstraint
            ])

        for state in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.disabled] {
            var button: EBKBaseButton
            switch self {
            case .autograyout:
                button = EBKAutoGrayOutButton()
            case .message:
                button = EBKMessageButton()
            case .withChevron:
                button = EBKButtonWithChevron()
            case .contactUs:
                button = EBKButtonContactUS()
            case .standardGreen:
                button = EBKButtonStandardGreen()
            case .treeBay:
                button = EBKButtonTreeBay(type: .custom)
            case .greenBorder:
                button = EBKButtonGreenBorder()
            }
            button.translatesAutoresizingMaskIntoConstraints = false
            button.buttonStyle = self

            switch state {
            case .normal:
                button.setTitle("Normal", for: state)
                button.isHighlighted = false
                button.isEnabled = true
                button.isSelected = false
            case .highlighted:
                button.setTitle("Pressed", for: state)
                button.isHighlighted = true
                button.isEnabled = false
                button.isSelected = false
            case .disabled:
                button.setTitle("Disabled", for: state)
                button.isHighlighted = false
                button.isEnabled = false
                button.isSelected = false

            default:
                fatalError()
            }

            stackView.addArrangedSubview(button)
        }
        return stackView
    }
}

@IBDesignable
public class EBKBaseButton: UIButton {
    public var buttonStyle: EBKButtonStyle! {
        didSet {
            setTitleColor(buttonStyle.titleColor, for: .normal)
            layer.cornerRadius = buttonStyle.cornerRadius
            backgroundColor = buttonStyle.backgroundColor
            titleLabel?.font = buttonStyle.titleFont
            tintColor = buttonStyle.tintColor
            clipsToBounds = true
            adjustsImageWhenDisabled = true
            adjustsImageWhenHighlighted = true
            titleLabel?.lineBreakMode = .byWordWrapping
            titleLabel?.textAlignment = .center
        }
    }

    func commonSetup() {
        // Code here will be executed in all setup states
    }

    convenience init() {
        self.init(frame: .zero)
        commonSetup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonSetup()
    }
}

public class EBKMessageButton: EBKBaseButton {
    override func commonSetup() {
        self.buttonStyle = .message
        setTitleColor(UIColor.ebkDarkGreen, for: .highlighted)
        setTitleColor(UIColor.ebkDarkGray, for: .disabled)
    }
}

public class EBKAutoGrayOutButton: EBKBaseButton {

    var grayOutView = UIView()

    override public var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                grayOutView.alpha = 1.0
            } else if !isHighlighted && !isSelected {
                grayOutView.alpha = 0.0
            }
        }
    }

    override func commonSetup() {
        buttonStyle = .autograyout
        grayOutView = UIView(frame: bounds)
        grayOutView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        grayOutView.backgroundColor = UIColor.ebkBlack.withAlphaComponent(0.15)
        grayOutView.isOpaque = true
        grayOutView.alpha = 0.0
        grayOutView.isUserInteractionEnabled = false
        insertSubview(grayOutView, belowSubview: titleLabel!)
    }

    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        grayOutView.alpha = 1.0
        return super.beginTracking(touch, with: event)
    }

    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        UIView.animate(withDuration: 0.6) {
            self.grayOutView.alpha = 0.0
        }
        super.endTracking(touch, with: event)
    }
}

public class EBKButtonWithChevron: EBKBaseButton {

    override func commonSetup() {
        buttonStyle = .withChevron
        let bundle = Bundle.EBKUIBundleForImages()
        let image = UIImage(named: "chevron_small_right", in: bundle, compatibleWith: nil)
        setImage(image, for: .normal)
    }

    override public func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var imageFrame = super.imageRect(forContentRect: contentRect)
        imageFrame.origin.x = 6 + super.titleRect(forContentRect: contentRect).maxX - imageFrame.width
        return imageFrame
    }

    override public func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var titleFrame = super.titleRect(forContentRect: contentRect)
        if self.currentImage != nil {
            titleFrame.origin.x = super.imageRect(forContentRect: contentRect).minX
        }
        return titleFrame
    }
}

public class EBKButtonContactUS: EBKBaseButton {

    override public var backgroundColor: UIColor? {
        didSet {
            self.setBackgroundImage(backgroundColor?.toImage(size: CGSize(width: 1, height: 1)), for: .normal)
            self.setBackgroundImage(backgroundColor?.darker(by: 10)?.toImage(size: CGSize(width: 1, height: 1)), for: .highlighted)
        }
    }

    override public func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        super.setTitleColor(color, for: .highlighted)
        super.setTitleColor(color?.withAlphaComponent(0.5), for: .disabled)
    }
    override func commonSetup() {
        buttonStyle = .contactUs
    }
}

@IBDesignable
public class EBKButtonStandardGreen: EBKBaseButton {

    override public var backgroundColor: UIColor? {
        didSet {
            self.setBackgroundImage(backgroundColor?.toImage(size: CGSize(width: 1, height: 1)), for: .normal)
            self.setBackgroundImage(backgroundColor?.darker(by: 10)?.toImage(size: CGSize(width: 1, height: 1)), for: .highlighted)
        }
    }

    override public func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        super.setTitleColor(color, for: .highlighted)
        super.setTitleColor(color?.withAlphaComponent(0.5), for: .disabled)
    }
    override func commonSetup() {
        buttonStyle = .standardGreen
    }
}

public class EBKButtonGreenBorder: EBKBaseButton {

    override func commonSetup() {
        buttonStyle = .greenBorder
        layer.borderColor = buttonStyle.borderColor.cgColor
        layer.borderWidth = 1.0
    }

}

@IBDesignable
public class EBKButtonTreeBay: EBKBaseButton {
    override func commonSetup() {
        buttonStyle = .treeBay
    }
}
