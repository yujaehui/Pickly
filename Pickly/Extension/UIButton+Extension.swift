//
//  UIButton+Extension.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import UIKit

extension UIButton {
    func greenButton(_ title: String) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = FontStyle.primary
        self.backgroundColor = ColorStyle.point
        self.tintColor = ColorStyle.text
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func configureProfileButton() {
        self.setTitle("", for: .normal)
        self.setImage(UIImage(named: "profile\(UserDefaultsManager.shared.profileImage)"), for: .normal)
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 4
        self.layer.borderColor = ColorStyle.point.cgColor
    }
}
