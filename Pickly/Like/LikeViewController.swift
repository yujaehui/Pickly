//
//  LikeViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 3/5/25.
//

import UIKit

class LikeViewController: BaseViewController {
    @IBOutlet var likeEmptyLabel: UILabel!
    @IBOutlet var likeTableView: UITableView!
    
    private var likeItems: [LikeItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func setNavigation() {
        super.setNavigation()
        navigationItem.title = "좋아요한 상품"
    }
    
    override func configureView() {
        super.configureView()
        likeEmptyLabel.text = "좋아요한 상품이 없습니다."
        likeEmptyLabel.textColor = ColorStyle.text
        likeEmptyLabel.font = FontStyle.secondary
        fetchLikeItems()
    }
    
    private func fetchLikeItems() {
        likeItems = LikeItemRepository.shared.fetchItem()
        updateUIForLikeItem()
    }
    
    private func updateUIForLikeItem() {
        let hasLikeItems = !likeItems.isEmpty
        likeEmptyLabel.isHidden = hasLikeItems
        likeTableView.isHidden = !hasLikeItems
        likeTableView.reloadData()
    }
    
    @objc func heartButtonClicked(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? LikeTableViewCell,
                  let indexPath = likeTableView.indexPath(for: cell) else { return }
        let likeItem = likeItems[indexPath.row]
        
        if likeItems.contains(where: { $0.id == likeItem.id }) {
            LikeItemRepository.shared.deleteItem(likeItem)
        } else {
            LikeItemRepository.shared.createItem(likeItem)
        }

        NotificationCenter.default.post(name: NSNotification.Name(Noti.heartButtonClicked.rawValue), object: nil)
        fetchLikeItems()
    }
}

extension LikeViewController {
    func configureTableView() {
        likeTableView.register(
            UINib(nibName: LikeTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: LikeTableViewCell.identifier
        )
        likeTableView.dataSource = self
        likeTableView.delegate = self
        likeTableView.rowHeight = 138
    }
}

extension LikeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LikeTableViewCell.identifier, for: indexPath) as! LikeTableViewCell
        let row = indexPath.row
        cell.configureCell(likeItems[row])
        cell.heartButton.addTarget(self, action: #selector(heartButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let sb = UIStoryboard(name: StoryboardName.Search.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchDetailViewController.identifier) as! SearchDetailViewController
        vc.id = likeItems[row].id
        vc.name = TextProcessingManager.shared.removeHTMLTags(from: likeItems[row].title)
        navigationController?.pushViewController(vc, animated: true)
    }
}
