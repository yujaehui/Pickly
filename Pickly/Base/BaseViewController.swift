//
//  BaseViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorStyle.background
        self.navigationItem.backButtonTitle = ""
    }
}
