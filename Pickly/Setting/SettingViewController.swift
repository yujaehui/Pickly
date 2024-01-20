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
    case notice = "공지사항"
    case faq = "자주 묻는 질문"
    case inquiry = "1:1 문의"
    case notification = "알림 설정"
    case reset = "처음부터 시작하기"
}

final class SettingViewController: BaseViewController {
    
    @IBOutlet var settingTableView: UITableView!
    
    var count = 0 {
        didSet { settingTableView.reloadData() }
    }
    
    var profileImage = 0
    var nickname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        configureView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        count = UserDefaultsManager.shared.productID?.count ?? 0
        profileImage = UserDefaultsManager.shared.profileImage
        nickname = UserDefaultsManager.shared.nickname
    }
}

extension SettingViewController {
    func setNavigation() {
        navigationItem.title = "설정"
    }
}

extension SettingViewController {
    func configureView() {
        settingTableView.setScrollViewBackgroundColor()
    }
}

extension SettingViewController {
    func configureTableView() {
        let profilexib = UINib(nibName: ProfileTableViewCell.identifier, bundle: nil)
        settingTableView.register(profilexib, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        let settingxib = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        settingTableView.register(settingxib, forCellReuseIdentifier: SettingTableViewCell.identifier)
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
            cell.profileImageView.image = UIImage(named: "profile\(profileImage)")
            cell.nicknameLabel.text = nickname
            cell.likeStateLabel.attributedText = TextProcessingManager.shared.textColorChange("\(count)개의 상품을 좋아하고 있어요!", changeText: "\(count)개의 상품")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            cell.settingLabel.text = SettingOption.allCases[indexPath.row].rawValue
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SettingType.profile.rawValue {
            let sb = UIStoryboard(name: "Profile", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.identifier) as! ProfileViewController
            vc.accessType = .edit
            vc.profileImage = UserDefaultsManager.shared.profileImage
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == SettingType.setting.rawValue && indexPath.row == 4 {
            showAlert(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", buttonTitle: "확인") {
                UserDefaultsManager.shared.clearAll()           // 모든 userDefaults 항목 제거
                UIApplication.shared.switchToOnboarding()       // 지금까지의 화면 제거하고 다시 온보딩 화면으로 이동
            }
        }
    }
}
