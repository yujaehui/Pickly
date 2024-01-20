//
//  SettingTableViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/20/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        backgroundColor = .secondaryLabel
        
        settingLabel.textColor = ColorStyle.text
        settingLabel.font = FontStyle.tertiary
    }
}
