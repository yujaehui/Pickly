//
//  SettingTableViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/20/24.
//

import UIKit

class SettingTableViewCell: BaseTableViewCell {
    @IBOutlet var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .secondaryLabel
        settingLabel.textColor = ColorStyle.text
        settingLabel.font = FontStyle.tertiary
    }
    
    func configureCell(_ row: Int) {
        settingLabel.text = SettingOption.allCases[row].rawValue
    }
}
