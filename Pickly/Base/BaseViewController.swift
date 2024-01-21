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
        setNavigation()
        configureView()
    }
    
    func setNavigation() {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: ColorStyle.text]
        self.navigationController?.navigationBar.tintColor = ColorStyle.text
    }
    
    func configureView() {
        self.view.backgroundColor = ColorStyle.background
        view.subviews.forEach {
            if let scrollView = $0 as? UIScrollView {
                scrollView.backgroundColor = ColorStyle.background
            }
        }
    }
}
