//
//  UIImageView+Extension.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import UIKit

extension UIImageView {
    func configureProfileImageView() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 4
        self.layer.borderColor = ColorStyle.point.cgColor
    }
}
