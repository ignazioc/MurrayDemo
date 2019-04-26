//
//  UIColor+EBKUI.swift
//  eBay Kleinanzeigen
//
//  Created by Calo, Ignazio on 5/11/18.
//  Copyright © 2018 eBay Kleinanzeigen. All rights reserved.
//

public extension UIColor {

    @objc class var ebkWhite: UIColor {
        return ColorName.ebkWhite.color
    }
    @objc class var ebkBlack: UIColor {
        return ColorName.ebkBlack.color
    }
    @objc class var ebkLightGray: UIColor {
        return ColorName.ebkLightGray.color
    }
    @objc class var ebkGray: UIColor {
        return ColorName.ebkGray.color
    }
    @objc class var ebkDarkGray: UIColor {
        return ColorName.ebkDarkGray.color
    }
    @objc class var ebkSearchBarGray: UIColor {
        return ColorName.ebkSearchBarGray.color
    }
    @objc class var ebkLightGreen: UIColor {
        return ColorName.ebkLightGreen.color
    }
    @objc class var ebkGreen: UIColor {
        return ColorName.ebkGreen.color
    }
    @objc class var ebkFilterDarkGreen: UIColor {
        return ColorName.ebkFilterDarkGreen.color
    }
    @objc class var ebkFilterLightGreen: UIColor {
        return ColorName.ebkFilterLightGreen.color
    }
    @objc class var ebkBlue: UIColor {
        return ColorName.ebkBlue.color
    }
    @objc class var ebkDarkGreen: UIColor {
        return ColorName.ebkDarkGreen.color
    }
    @objc class var ebkYellow: UIColor {
        return ColorName.ebkYellow.color
    }
    @objc class var ebkOrange: UIColor {
        return ColorName.ebkOrange.color
    }
    @objc class var ebkRed: UIColor {
        return ColorName.ebkRed.color
    }
    @objc class var ebkLightRed: UIColor {
        return ColorName.ebkLightRed.color
    }
    @objc class var ebkLightYellow: UIColor {
        return ColorName.ebkLightYellow.color
    }
    @objc class var ebkLocationCircle: UIColor {
        return UIColor.ebkGreen.withAlphaComponent(0.3)
    }
    @objc class var ebkTableViewCellHighlightedOrSelectedOverlay: UIColor {
        return UIColor.ebkBlack.withAlphaComponent(0.15)
    }
    @objc class var ebkAlertComponentBackground: UIColor {
        return UIColor.ebkWhite.withAlphaComponent(0.90)
    }
}

public extension UIColor {

    static var allEBKColors: [StyleGuideViewable] {
        return [
            ColorStyleGuide(color: UIColor.ebkWhite, name: "ebkWhite"),
            ColorStyleGuide(color: UIColor.ebkBlack, name: "ebkBlack"),
            ColorStyleGuide(color: UIColor.ebkLightGray, name: "ebkLightGray"),
            ColorStyleGuide(color: UIColor.ebkGray, name: "ebkGray"),
            ColorStyleGuide(color: UIColor.ebkDarkGray, name: "ebkDarkGray"),
            ColorStyleGuide(color: UIColor.ebkSearchBarGray, name: "ebkSearchBarGray"),
            ColorStyleGuide(color: UIColor.ebkLightGreen, name: "ebkLightGreen"),
            ColorStyleGuide(color: UIColor.ebkGreen, name: "ebkGreen"),
            ColorStyleGuide(color: UIColor.ebkBlue, name: "ebkBlue"),
            ColorStyleGuide(color: UIColor.ebkDarkGreen, name: "ebkDarkGreen"),
            ColorStyleGuide(color: UIColor.ebkYellow, name: "ebkYellow"),
            ColorStyleGuide(color: UIColor.ebkOrange, name: "ebkOrange"),
            ColorStyleGuide(color: UIColor.ebkRed, name: "ebkRed"),
            ColorStyleGuide(color: UIColor.ebkLightRed, name: "ebkLightRed"),
            ColorStyleGuide(color: UIColor.ebkLightYellow, name: "ebkLightYellow")
        ]
    }

     @objc func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

     @objc func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

     @objc func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r + percentage / 100, 1.0),
                           green: min(g + percentage / 100, 1.0),
                           blue: min(b + percentage / 100, 1.0),
                           alpha: a)
        }
        return nil
    }

    func toImage(size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}

struct ColorStyleGuide {

    var rawValue: String
    let color: UIColor
    let itemName: String

    init(color: UIColor, name: String) {
        self.color = color
        self.rawValue = name
        self.itemName = name
    }
}

extension ColorStyleGuide: StyleGuideViewable {
    public var example: UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let heigthConstraint = view.heightAnchor.constraint(equalToConstant: 50)
        heigthConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 300),
            heigthConstraint
            ])
        view.backgroundColor = self.color
        return view
    }
}
