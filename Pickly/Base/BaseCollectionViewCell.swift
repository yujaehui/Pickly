//
//  BaseCollectionViewCell.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder) // 스토리보드에서 사용 가능하도록 설정
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = ColorStyle.background
    }
}
