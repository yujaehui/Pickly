//
//  SearchResultViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import UIKit
import Alamofire
import Kingfisher

enum Sort: String, CaseIterable {
    case sim
    case date
    case dsc
    case asc
    
    var text: String {
        switch self {
        case .sim: "정확도순"
        case .date: "날짜순"
        case .dsc: "가격높은순"
        case .asc: "가격낮은순"
        }
    }
}

class SearchResultViewController: BaseViewController {
    @IBOutlet var resultCountLabel: UILabel!
    @IBOutlet var sortCollectionView: UICollectionView!
    @IBOutlet var resultCollectionView: UICollectionView!
    @IBOutlet var emptyLabel: UILabel!
    
    private var likeItems: [LikeItem] = []
    
    var searchText = ""
    var shoppingList = Shopping()
    var total = 0
    var start = 1
    
    var sort: Sort = .sim {
        didSet { sortCollectionView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        callRequest()
    }
    
    override func setNavigation() {
        super.setNavigation()
        navigationItem.title = searchText
    }
    
    override func configureView() {
        super.configureView()
        resultCountLabel.textColor = ColorStyle.point
        resultCountLabel.font = FontStyle.tertiary
        emptyLabel.text = "상품을 찾을 수 없어요"
        emptyLabel.textColor = ColorStyle.text
        emptyLabel.textAlignment = .center
        emptyLabel.font = FontStyle.primary
        fetchLikeItems()
    }
    
    private func fetchLikeItems() {
        likeItems = LikeItemRepository.shared.fetchItem()
        resultCollectionView.reloadData()
    }
    
    @objc func heartButtonClicked(_ sender: UIButton) {
        let item = shoppingList.items[sender.tag]
        
        // 좋아요 목록에서 해당 아이템을 찾기
        if let likeItem = likeItems.first(where: { $0.id == item.productID }) {
            LikeItemRepository.shared.deleteItem(likeItem)
        } else {
            let newLikeItem = LikeItem(id: item.productID, brand: item.brand, title: item.title, price: item.lprice, link: item.link)
            LikeItemRepository.shared.createItem(newLikeItem)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(Noti.heartButtonClicked.rawValue), object: nil)
        fetchLikeItems()
    }
}

extension SearchResultViewController {
    func configureCollectionView() {
        sortCollectionView.register(
            UINib(nibName: SortCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: SortCollectionViewCell.identifier
        )
        
        sortCollectionView.dataSource = self
        sortCollectionView.delegate = self
        
        let sortCollectionViewLayout = UICollectionViewFlowLayout()
        sortCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        sortCollectionViewLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        sortCollectionViewLayout.minimumLineSpacing = 8
        sortCollectionViewLayout.minimumInteritemSpacing = 8
        sortCollectionView.collectionViewLayout = sortCollectionViewLayout
        
        
        resultCollectionView.register(
            UINib(nibName: SearchResultCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier
        )
        
        resultCollectionView.dataSource = self
        resultCollectionView.delegate = self
        resultCollectionView.prefetchDataSource = self
        
        let resultCollectionViewLayout = UICollectionViewFlowLayout()
        let resultCollectionViewSpacing: CGFloat = 16
        let resultCollectionViewCellWidth = UIScreen.main.bounds.width - (resultCollectionViewSpacing * 3)
        resultCollectionViewLayout.itemSize = CGSize(width: resultCollectionViewCellWidth / 2, height: resultCollectionViewCellWidth / 2 + 120)
        resultCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: resultCollectionViewSpacing, bottom: resultCollectionViewSpacing, right: resultCollectionViewSpacing)
        resultCollectionViewLayout.minimumLineSpacing = resultCollectionViewSpacing
        resultCollectionViewLayout.minimumInteritemSpacing = resultCollectionViewSpacing
        resultCollectionView.collectionViewLayout = resultCollectionViewLayout
    }
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == sortCollectionView ? Sort.allCases.count : shoppingList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sortCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortCollectionViewCell.identifier, for: indexPath) as! SortCollectionViewCell
            let row = indexPath.row
            cell.configureCell(row, sort: sort)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
            let row = indexPath.row
            let item = shoppingList.items[row]
            let likeItems = likeItems
            cell.configureCell(row, item: item, likeItems: likeItems)
            cell.heartButton.addTarget(self, action: #selector(heartButtonClicked), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sortCollectionView {
            sort = Sort.allCases[indexPath.row]
            start = 1
            callRequest()
        } else {
            let sb = UIStoryboard(name: StoryboardName.Search.rawValue, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: SearchDetailViewController.identifier) as! SearchDetailViewController
            vc.id = shoppingList.items[indexPath.row].productID
            vc.name = TextProcessingManager.shared.removeHTMLTags(from: shoppingList.items[indexPath.row].title)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if shoppingList.items.count - 3 == item.row && total != item.row {
                start += 20
                if start < total {
                    callRequest()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("cancel prefetch \(indexPaths)")
    }
}

extension SearchResultViewController {
    func callRequest() {
        Task {
            let shopping = try await SearchSessionManager.shared.fetchSearch(api: ShoppingAPI.search(query: searchText, start: start, sort: sort.rawValue))
            self.total = shopping.total
            
            if self.total == 0 {
                self.showEmptyState(true)
            } else if self.start == 1 {
                self.showEmptyState(false)
                self.shoppingList = shopping
            } else {
                self.shoppingList.items.append(contentsOf: shopping.items)
            }
            
            self.resultCountLabel.text = "\(NumberFormatterManager.shared.formatQuantity(self.total))개의 검색 결과"
            
            self.resultCollectionView.reloadData()
            
            if self.start == 1 && self.total > 0 {
                self.resultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            }
        }
        
//        SearchSessionManager.request(request: ShoppingAPI.search(query: searchText, start: start, sort: sort.rawValue).endpoint) { (shopping: Shopping?, error: ErrorType?) in
//            if error == nil {
//                guard let shopping = shopping else { return }
//                self.total = shopping.total
//                
//                if self.total == 0 {
//                    self.showEmptyState()
//                } else if self.start == 1 {
//                    self.shoppingList = shopping
//                } else {
//                    self.shoppingList.items.append(contentsOf: shopping.items)
//                }
//                
//                self.resultCountLabel.text = "\(self.formatQuantity(self.total))개의 검색 결과"
//                
//                self.resultCollectionView.reloadData()
//                
//                if self.start == 1 && self.total > 0 {
//                    self.resultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
//                }
//            }
//        }
        
//        SearchSessionManager.searchRequest(query: searchText, start: start, sort: sort.rawValue) { shopping, error in
//            if error == nil {
//                guard let shopping = shopping else { return }
//                self.total = shopping.total
//
//                if self.total == 0 {
//                    self.showEmptyState()
//                } else if self.start == 1 {
//                    self.shoppingList = shopping
//                } else {
//                    self.shoppingList.items.append(contentsOf: shopping.items)
//                }
//
//                self.resultCountLabel.text = "\(self.formatQuantity(self.total))개의 검색 결과"
//
//                self.resultCollectionView.reloadData()
//
//                if self.start == 1 && self.total > 0 {
//                    self.resultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
//                }
//            }
//        }
    }
    
    // 검색 결과가 없을 때의 UI 처리
    func showEmptyState(_ state: Bool) {
        resultCountLabel.isHidden = state
        resultCollectionView.isHidden = state
        emptyLabel.isHidden = !state
    }
}
