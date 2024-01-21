//
//  RecentSearchTableViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import UIKit

class RecentSearchTableViewCell: BaseTableViewCell {
    @IBOutlet var magnifyingglassImageView: UIImageView!
    @IBOutlet var recentSearchLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        magnifyingglassImageView.image = UIImage(systemName: "magnifyingglass")
        magnifyingglassImageView.tintColor = ColorStyle.text
        recentSearchLabel.font = FontStyle.tertiary
        recentSearchLabel.textColor = ColorStyle.text
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteButton.tintColor = .lightGray
    }
    
    func configureCell(_ row: Int) {
        if let searchList = UserDefaultsManager.shared.searchList {
            recentSearchLabel.text = searchList[row]
        }
        deleteButton.tag = row
    }
}
