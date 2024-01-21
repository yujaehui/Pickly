//
//  SettingViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/20/24.
//

import UIKit

enum SettingType: Int, CaseIterable {
    case profile
    case setting
}

enum SettingOption: String, CaseIterable {
    case like = "좋아요한 상품"
    case notice = "공지사항"
    case faq = "자주 묻는 질문"
    case inquiry = "1:1 문의"
    case notification = "알림 설정"
    case reset = "처음부터 시작하기"
}

final class SettingViewController: BaseViewController {
    @IBOutlet var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfile), name: NSNotification.Name(Noti.profileChanged.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfile), name: NSNotification.Name(Noti.heartButtonClicked.rawValue), object: nil)
    }
    
    override func setNavigation() {
        super.setNavigation()
        navigationItem.title = "설정"
    }
    
    override func configureView() {
        super.configureView()
    }
    
    @objc func updateProfile() {
        settingTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(Noti.profileChanged.rawValue), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(Noti.heartButtonClicked.rawValue), object: nil)
    }
}

extension SettingViewController {
    func configureTableView() {
        settingTableView.register(
            UINib(nibName: ProfileTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProfileTableViewCell.identifier
        )
        settingTableView.register(
            UINib(nibName: SettingTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: SettingTableViewCell.identifier
        )
        settingTableView.dataSource = self
        settingTableView.delegate = self
        settingTableView.rowHeight = UITableView.automaticDimension
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == SettingType.profile.rawValue ? 1 : SettingOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SettingType.profile.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            cell.configureCell()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            let row = indexPath.row
            cell.configureCell(row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingType(rawValue: indexPath.section) {
        case .profile:
            let sb = UIStoryboard(name: StoryboardName.Profile.rawValue, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.identifier) as! ProfileViewController
            vc.accessType = .edit
            navigationController?.pushViewController(vc, animated: true)
        case .setting:
            guard let option = SettingOption(rawValue: SettingOption.allCases[indexPath.row].rawValue) else { return }
            switch option {
            case .like:
                let sb = UIStoryboard(name: StoryboardName.Like.rawValue, bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: LikeViewController.identifier) as! LikeViewController
                navigationController?.pushViewController(vc, animated: true)
            case .reset:
                showAlert(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", buttonTitle: "확인") {
                    UserDefaultsManager.shared.clearAll()
                    LikeItemRepository.shared.clearRealmData()
                    UIApplication.shared.switchToOnboarding()
                }
            default: return
            }
        case .none: break
        }
    }
}
