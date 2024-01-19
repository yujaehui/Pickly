//
//  ProfileViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import UIKit

enum AccessType: String {
    case setting = "프로필 설정"
    case edit = "프로필 수정"
}

enum NicknameState {
    case valid
    case tooShort
    case tooLong
    case containsForbiddenCharacter
    case containsNumber
    case startsWithSpace
    case containsConsecutiveSpaces
    
    var message: String {
        switch self {
        case .valid:
            return "사용할 수 있는 닉네임이에요."
        case .tooShort, .tooLong:
            return "닉네임은 2글자 이상, 10글자 이내로 설정해주세요."
        case .containsForbiddenCharacter:
            return "닉네임에 @, #, $, %를 입력할 수 없어요."
        case .containsNumber:
            return "닉네임에 숫자는 입력할 수 없어요."
        case .startsWithSpace:
            return "닉네임은 공백으로 시작할 수 없어요."
        case .containsConsecutiveSpaces:
            return "닉네임에 공백을 연속으로 사용할 수 없어요."
        }
    }
    
    var color: UIColor {
        switch self {
        case .valid:
            return ColorStyle.point
        default:
            return .systemRed
        }
    }
    
    var isEnabled: Bool {
        return self == .valid
    }
}

final class ProfileViewController: BaseViewController {
    
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nicknameStateLabel: UILabel!
    @IBOutlet var completeButton: UIButton!
    
    var accessType: AccessType = .setting
    var profileImage = Int.random(in: 1...14)

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        configureView()
        profileButton.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileButton.setImage(UIImage(named: "profile\(UserDefaultsManager.shared.profileImage)"), for: .normal)
    }
    
    @IBAction func textFieldState(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if text.isEmpty { completeButton.isEnabled = false }
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let state = validateNickname(text)
        stateTextField(state)
    }
    
    private func validateNickname(_ text: String) -> NicknameState {
        let forbiddenCharacters = ["@", "#", "$", "%"]
        let forbiddenNumbers = ["0","1","2","3","4","5","6","7","8","9"]
        
        if text.count < 2 {
            return .tooShort
        } else if text.count > 10 {
            return .tooLong
        } else if forbiddenCharacters.contains(where: { text.contains($0) }) {
            return .containsForbiddenCharacter
        } else if forbiddenNumbers.contains(where: { text.contains($0) }) {
            return .containsNumber
        } else if text.first == " " {
            return .startsWithSpace
        } else if text.contains("  ") {
            return .containsConsecutiveSpaces
        } else {
            return .valid
        }
    }
    
    private func stateTextField(_ state: NicknameState) {
        nicknameStateLabel.text = state.message
        nicknameStateLabel.textColor = state.color
        completeButton.isEnabled = state.isEnabled
    }
    
    @objc func profileButtonClicked() {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileImageViewController.identifier) as! ProfileImageViewController
        vc.accessType = accessType
        vc.profileImage = UserDefaultsManager.shared.profileImage
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func completeButtonClicked() {
        guard let nickname = nicknameTextField.text else { return }
        UserDefaultsManager.shared.nickname = nickname
        
        // TODO: Navigate to SearchViewController
    }
}

extension ProfileViewController {
    func setNavigation() {
        navigationItem.title = accessType.rawValue
    }
}

extension ProfileViewController {
    func configureView() {
        cameraImageView.image = .camera

        if UserDefaultsManager.shared.profileImage == 0 {
            UserDefaultsManager.shared.profileImage = profileImage
        }
        profileButton.configureProfileButton()
    
        nicknameTextField.becomeFirstResponder()
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        nicknameTextField.textColor = ColorStyle.text
        nicknameTextField.borderStyle = .none
        nicknameTextField.underLine(viewSize: view.bounds.width, color: ColorStyle.text)
        nicknameTextField.text = accessType == .setting ? "" : UserDefaultsManager.shared.nickname
        
        nicknameStateLabel.text = ""
        nicknameStateLabel.font = FontStyle.tertiary
        
        completeButton.greenButton("완료")
    }
}
