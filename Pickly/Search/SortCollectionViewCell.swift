//
//  SortCollectionViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import UIKit

class SortCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet var sortLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        sortLabel.font = FontStyle.tertiary
        sortLabel.textAlignment = .center
        sortLabel.numberOfLines = 1
        sortLabel.clipsToBounds = true
        sortLabel.layer.cornerRadius = 5
        sortLabel.layer.borderColor = ColorStyle.text.cgColor
        sortLabel.layer.borderWidth = 1
    }
}
