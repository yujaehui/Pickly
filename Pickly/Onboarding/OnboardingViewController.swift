//
//  OnboardingViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var onboardingImageView: UIImageView!
    @IBOutlet var startButton: UIButton!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.identifier) as! ProfileViewController
        vc.accessType = .setting
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension OnboardingViewController {
    func configureView() {
        logoImageView.image = .logo
        onboardingImageView.image = .onboarding
        startButton.greenButton("시작하기")
    }
}
