//
//  EBKEmptyStateView.swift
//  eBay Kleinanzeigen
//
//  Created by Deecke, Roddi on 16.06.16.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

import UIKit

@objcMembers
public class EBKEmptyStateView: UIView {

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var imageView: UIImageView!

    private var labelPaddingConstraintsConstant: CGFloat = 20.0

    var buttonHandler: (() -> Void)?

    public class func newEmptyStateView(_ content: EBKEmptyStateContentProtocol) -> EBKEmptyStateView {
        let nib = UINib(nibName: "EBKEmptyStateView", bundle: Bundle.EBKUIBundleForXib())
        let view = (nib.instantiate(withOwner: nil, options: nil).first as? EBKEmptyStateView)!
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setup(content)
        view.layoutIfNeeded()
        view.frame.size = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return view
    }

    func setup(_ content: EBKEmptyStateContentProtocol) {
        if let buttonTitle = content.buttonTitle, let handler = content.buttonHandler {
            buttonHandler = handler
            button.setTitle(buttonTitle, for: UIControl.State())
        } else {
            button.isHidden = true
        }

        messageLabel.text = content.message
        messageLabel.accessibilityLabel = content.message
        titleLabel.text = content.title
        titleLabel.accessibilityLabel = content.title

        if let image = content.image {
            imageView.image = image
        } else {
            imageView.isHidden = true
        }
    }

    override public func layoutSubviews() {
        messageLabel.preferredMaxLayoutWidth = bounds.size.width - 2 * labelPaddingConstraintsConstant
        titleLabel.preferredMaxLayoutWidth = bounds.size.width - 2 * labelPaddingConstraintsConstant

        super.layoutSubviews()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()

        button.titleLabel?.font = EBKFont.standard.of(size: .normal)

        titleLabel.font = EBKFont.standard.of(size: .large)
        titleLabel.textColor = UIColor.ebkDarkGray

        messageLabel.font = EBKFont.standard.of(size: .normal)
        messageLabel.textColor = UIColor.ebkDarkGray
    }

    @IBAction func handleButton(_ sender: UIButton) {
        buttonHandler?()
    }

}
