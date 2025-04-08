//
//  AppDelegate.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        if UserDataManager.shared.isUserLoggedIn() {
            showNewsFeedScreen()
        } else {
            showLoginScreen()
        }
        
        return true
    }
    
    func showLoginScreen() {
        let loginVC = LoginVC()
        let launch = UINavigationController(rootViewController: loginVC)
        launch.interactivePopGestureRecognizer?.isEnabled = false
        launch.navigationBar.isHidden = true
        self.window?.rootViewController = launch
        self.window?.makeKeyAndVisible()
    }
    
    func showNewsFeedScreen() {
        let newsVC = FeedsListVC()
        let launch = UINavigationController(rootViewController: newsVC)
        launch.interactivePopGestureRecognizer?.isEnabled = false
        launch.navigationBar.isHidden = true
        self.window?.rootViewController = launch
        self.window?.makeKeyAndVisible()
    }
    
}

