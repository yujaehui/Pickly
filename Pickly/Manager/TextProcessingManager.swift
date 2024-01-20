//
//  TextProcessingManager.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/20/24.
//

import Foundation
import UIKit

class TextProcessingManager {
    static let shared = TextProcessingManager()
    private init() {}
    
    func textColorChange(_ labelText: String, changeText: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: labelText)
        let countRange = (labelText as NSString).range(of: changeText)
        let countAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: ColorStyle.point]
        attributedText.addAttributes(countAttributes, range: countRange)
        return attributedText
    }
}
