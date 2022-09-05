//
//  AppDelegate.swift
//  Bankey
//
//  Created by RuslanS on 7/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        window?.rootViewController = loginViewController
//        window?.rootViewController = onboardingContainerViewController
//        window?.rootViewController = OnboardingViewController(heroImageName: "delorean", tittleText: "Bankey is faster, easier to use, and has a fresh new look and feel that will make you feel like you are in the 80's")
        
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        setRootViewController(onboardingContainerViewController)
    }
}
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        print("RSPrint - Did finish onboarding")
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
