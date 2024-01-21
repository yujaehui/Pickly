//
//  SearchResultCollectionViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import UIKit

class SearchResultCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.layer.cornerRadius = 10
        brandLabel.font = FontStyle.tertiary
        brandLabel.textColor = .lightGray
        productNameLabel.font = FontStyle.secondary
        productNameLabel.textColor = ColorStyle.text
        productNameLabel.numberOfLines = 2
        priceLabel.font = FontStyle.primary
        priceLabel.textColor = ColorStyle.text
        heartButton.setTitle("", for: .normal)
        heartButton.tintColor = ColorStyle.background
        heartButton.backgroundColor = ColorStyle.text
        heartButton.layer.cornerRadius = heartButton.frame.width / 2
        heartButton.clipsToBounds = true
    }
    
    func configureCell(_ row: Int, item: Item) {
        let imageURL = URL(string: item.image)
        productImageView.kf.setImage(with: imageURL)
        brandLabel.text = item.brand
        productNameLabel.text = TextProcessingManager.shared.removeHTMLTags(from: item.title)
        priceLabel.text = NumberFormatterManager.shared.formatCurrency(item.lprice)
        if let idList = UserDefaultsManager.shared.productID {
            let heartImage = idList.contains(item.productID) ? "heart.fill" : "heart"
            heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
        }
        heartButton.tag = row
    }
}
