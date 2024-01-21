//
//  LikeTableViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 3/5/25.
//

import UIKit

class LikeTableViewCell: BaseTableViewCell {
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .secondaryLabel
        brandLabel.font = FontStyle.tertiary
        brandLabel.textColor = ColorStyle.text
        titleLabel.font = FontStyle.secondary
        titleLabel.textColor = ColorStyle.text
        priceLabel.font = FontStyle.primary
        priceLabel.textColor = ColorStyle.text
        heartButton.setTitle("", for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        heartButton.tintColor = ColorStyle.text
    }
    
    func configureCell(_ item: LikeItem) {
        brandLabel.text = item.brand
        titleLabel.text = TextProcessingManager.shared.removeHTMLTags(from: item.title)
        priceLabel.text = NumberFormatterManager.shared.formatCurrency(item.price)
    }
}
