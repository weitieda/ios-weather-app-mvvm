//
//  AppDelegate.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-11.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        window?.rootViewController = RootViewController()
        
        return true
    }
}

