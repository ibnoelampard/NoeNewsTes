//
//  AppDelegate.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 21/06/23.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let vc = CategoryViewController.instance()
        let navigationController = UINavigationController()
        navigationController.addChild(vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        return true
    }


}

