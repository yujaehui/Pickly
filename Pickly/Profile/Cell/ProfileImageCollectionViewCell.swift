//
//  ProfileImageCollectionViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.contentMode = .scaleToFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
}
