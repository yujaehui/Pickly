//
//  UIViewController+Extension.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    func showAlert(title: String, message: String, buttonTitle: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completionHandler()
        }
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
