//
//  AppDelegate.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootVC()
        
        return true
    }

    // MARK: - Helper
    private func setRootVC() {
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: UIStoryboard.startVC)
        window?.makeKeyAndVisible()
    }
}
