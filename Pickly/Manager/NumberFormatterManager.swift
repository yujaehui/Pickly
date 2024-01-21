//
//  NumberFormatterManager.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import Foundation

class NumberFormatterManager {
    static let shared = NumberFormatterManager()
    private init() {}
    
    func formatCurrency(_ amountString: String) -> String? {
        guard let amount = Int(amountString) else {
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        if let formattedAmount = formatter.string(from: NSNumber(value: amount)) {
            return formattedAmount
        } else {
            return "\(amount)"
        }
    }
    
    func formatQuantity(_ count: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        
        if let formattedCount = formatter.string(from: NSNumber(value: count)) {
            return formattedCount
        } else {
            return "\(count)"
        }
    }
}
