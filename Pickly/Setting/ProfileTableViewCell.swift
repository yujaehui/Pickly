//
//  ProfileTableViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/20/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var likeStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        backgroundColor = .secondaryLabel
        
        profileImageView.configureProfileImageView()
        
        nicknameLabel.textColor = ColorStyle.text
        nicknameLabel.font = FontStyle.primary
    
        likeStateLabel.textColor = ColorStyle.text
        likeStateLabel.font = FontStyle.secondary
    }
}

