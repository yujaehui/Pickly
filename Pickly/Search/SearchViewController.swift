//
//  SearchViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var recentSearchLabel: UILabel!
    @IBOutlet var deleteAllButton: UIButton!
    @IBOutlet var emptyImageView: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    @IBOutlet var recentSearchTableView: UITableView!
    
    private var recentSearchList: [String] = UserDefaultsManager.shared.searchList ?? [] {
        didSet {
            UserDefaultsManager.shared.searchList = recentSearchList
            updateUIForRecentSearches()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        deleteAllButton.addTarget(self, action: #selector(deleteAllButtonClicked), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfile), name: NSNotification.Name(Noti.profileChanged.rawValue), object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func setNavigation() {
        super.setNavigation()
        navigationItem.title = "\(UserDefaultsManager.shared.nickname)의 새싹쇼핑"
    }
    
    override func configureView() {
        super.configureView()
        recentSearchTableView.setScrollViewBackgroundColor()
        
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = ColorStyle.text
        searchBar.searchTextField.backgroundColor = .secondaryLabel
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        
        recentSearchLabel.textColor = ColorStyle.text
        recentSearchLabel.font = FontStyle.tertiary
        
        deleteAllButton.setTitle("전체 삭제", for: .normal)
        deleteAllButton.tintColor = ColorStyle.point
        deleteAllButton.titleLabel?.font = FontStyle.tertiary
        
        emptyImageView.image = UIImage(named: "empty")
        
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.textColor = ColorStyle.text
        emptyLabel.font = FontStyle.primary
        emptyLabel.textAlignment = .center
        
        updateUIForRecentSearches()
    }
    
    private func updateUIForRecentSearches() {
        let hasRecentSearches = !recentSearchList.isEmpty
        recentSearchLabel.text = hasRecentSearches ? "최근 검색" : ""
        deleteAllButton.isHidden = !hasRecentSearches
        recentSearchTableView.isHidden = !hasRecentSearches
        recentSearchTableView.reloadData()
    }

    @objc func deleteButtonClicked(_ sender: UIButton) {
        recentSearchList.remove(at: sender.tag)
    }
    
    @objc func deleteAllButtonClicked() {
        recentSearchList.removeAll()
    }
    
    @objc func updateProfile() {
        setNavigation()
    }
    
    deinit {
        print("SearchViewController Deinit")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(Noti.profileChanged.rawValue), object: nil)
    }
}

extension SearchViewController {
    func configureTableView() {
        let xib = UINib(nibName: RecentSearchTableViewCell.identifier, bundle: nil)
        recentSearchTableView.register(xib, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        recentSearchTableView.dataSource = self
        recentSearchTableView.delegate = self
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as! RecentSearchTableViewCell
        let row = indexPath.row
        cell.recentSearchLabel.text = recentSearchList[row]
        cell.deleteButton.tag = row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = recentSearchList[indexPath.row]
        guard let text = searchBar.text, !text.isEmpty else { return }
        search(text: text)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        search(text: text)
    }
    
    private func search(text: String) {
        recentSearchList.removeAll { $0 == text }                       // 최근 검색어 목록에 해당 검색어와 같은 게 있는지 확인, 있다면 제거
        recentSearchList.insert(text, at: 0)                            // 이후 해당 검색어를 최근 검색어 목록 첫번째 항목에 추가
        if recentSearchList.count > 7 {                                 // 최근 검색어 목록의 총 항목 수가 7개를 넘으면 가장 오래된 항목 제거
            recentSearchList.removeLast()
        }
        UserDefaultsManager.shared.searchList = recentSearchList        // 이후 최근 검색어 목록을 저장소에 저장
        
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
        vc.searchText = text
        navigationController?.pushViewController(vc, animated: true)
        
        searchBar.text = ""
        updateUIForRecentSearches()
    }
}
