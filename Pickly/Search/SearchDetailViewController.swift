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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
        setTabBarAppearance()
        loadWebView()
    }
    
    override func setNavigation() {
        super.setNavigation()
        navigationItem.title = name
    }
    
    override func configureView() {
        super.configureView()
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
 
    // 탭 바 UI 설정
    private func setTabBarAppearance() {
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = ColorStyle.background
        tabBarController?.tabBar.standardAppearance = tabAppearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabAppearance
    }
    
    // 네이버 쇼핑 웹뷰 로드
    private func loadWebView() {
        let link = "https://msearch.shopping.naver.com/product/\(id)"
        guard let url = URL(string: link) else { return }
        webView.load(URLRequest(url: url))
    }
}
