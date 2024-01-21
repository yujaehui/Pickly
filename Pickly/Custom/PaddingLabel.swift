//
//  PaddingLabel.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import UIKit

class PaddingLabel: UILabel {
    var padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: padding)
        super.drawText(in: insetRect)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}
