//
//  ProfileTableViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/20/24.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var likeStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .secondaryLabel
        profileImageView.configureProfileImageView()
        nicknameLabel.textColor = ColorStyle.text
        nicknameLabel.font = FontStyle.primary
        likeStateLabel.textColor = ColorStyle.text
        likeStateLabel.font = FontStyle.secondary
    }
    
    func configureCell() {
        profileImageView.image = UIImage(named: "profile\(UserDefaultsManager.shared.profileImage)")
        nicknameLabel.text = UserDefaultsManager.shared.nickname
        let likeItems = LikeItemRepository.shared.fetchItem()
        likeStateLabel.attributedText = TextProcessingManager.shared.textColorChange("\(likeItems.count)개의 상품을 좋아하고 있어요!", changeText: "\(likeItems.count)개의 상품")
    }
}
