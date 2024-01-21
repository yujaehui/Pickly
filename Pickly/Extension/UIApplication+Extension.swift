//
//  UIApplication+Extension.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/20/24.
//

import UIKit

extension UIApplication {
    func switchToOnboarding() {
        guard let windowScene = connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let onboardingVC = storyboard.instantiateViewController(withIdentifier: OnboardingViewController.identifier) as! OnboardingViewController
        let navigationController = UINavigationController(rootViewController: onboardingVC)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func switchToMainTabBar() {
        guard let windowScene = connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }
        
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
        mainTabBarController.tabBar.backgroundColor = ColorStyle.background
        mainTabBarController.tabBar.barTintColor = ColorStyle.background
        mainTabBarController.tabBar.tintColor = ColorStyle.point
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
    }
}
