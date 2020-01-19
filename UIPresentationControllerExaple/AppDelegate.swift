//
//  AppDelegate.swift
//  UIPresentationControllerExaple
//
//  Created by Richie Shilton on 17/1/20.
//  Copyright © 2020 Richie Shilton. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}

