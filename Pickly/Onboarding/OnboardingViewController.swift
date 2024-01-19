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
        // TODO: Navigate to UserProfileView
    }
}

extension OnboardingViewController {
    func configureView() {
        // TODO: Add logo image
        logoImageView.image = UIImage(named: "")
        onboardingImageView.image = .onboarding
        startButton.greenButton("시작하기")
    }
}
