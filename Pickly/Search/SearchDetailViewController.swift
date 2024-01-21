//
//  SearchDetailViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import UIKit
import WebKit

class SearchDetailViewController: BaseViewController {
    @IBOutlet var webView: WKWebView!
    
    var id = ""
    var name = ""
    
    lazy var IDList: [String] = UserDefaultsManager.shared.productID ?? []

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        setNavigationBarAppearance()
        setNavigation()
        loadWebView()
    }
 
    // 탭 바 UI 설정
    private func setTabBarAppearance() {
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = ColorStyle.background
        tabBarController?.tabBar.standardAppearance = tabAppearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabAppearance
    }
    
    // 네비게이션 바 UI 설정
    private func setNavigationBarAppearance() {
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.titleTextAttributes = [.foregroundColor: ColorStyle.text]
        navigationAppearance.backgroundColor = ColorStyle.background
        navigationController?.navigationBar.standardAppearance = navigationAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
    }
    
    private func setNavigation() {
        navigationItem.title = name
        updateHeartButton()
    }
    
    @objc func heartButtonClicked(_ sender: UIButton) {
        if let index = IDList.firstIndex(of: id) {
            IDList.remove(at: index)
        } else {
            IDList.append(id)
        }
        UserDefaultsManager.shared.productID = IDList
        updateHeartButton()
    }
    
    // 하트 버튼 UI 업데이트
    private func updateHeartButton() {
        let heartImage = IDList.contains(id) ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: heartImage),
            style: .plain,
            target: self,
            action: #selector(heartButtonClicked)
        )
    }
    
    // 네이버 쇼핑 웹뷰 로드
    private func loadWebView() {
        let link = "https://msearch.shopping.naver.com/product/\(id)"
        guard let url = URL(string: link) else { return }
        webView.load(URLRequest(url: url))
    }
}
