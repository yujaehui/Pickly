//
//  OnboardingViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import UIKit

enum StoryboardName: String {
    case Onboarding
    case Profile
    case Setting
    case Search
    case Like
}

final class OnboardingViewController: BaseViewController {
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var onboardingImageView: UIImageView!
    @IBOutlet var startButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    override func setNavigation() {
        super.setNavigation()
    }
    
    override func configureView() {
        super.configureView()
        logoImageView.image = .logo
        onboardingImageView.image = .onboarding
        startButton.greenButton("시작하기")
    }
    
    @objc func startButtonClicked() {
        let sb = UIStoryboard(name: StoryboardName.Profile.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.identifier) as! ProfileViewController
        vc.accessType = .setting
        navigationController?.pushViewController(vc, animated: true)
    }
}
