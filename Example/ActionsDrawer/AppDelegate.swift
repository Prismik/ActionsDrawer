//
//  AppDelegate.swift
//  ActionsDrawer
//
//  Created by Francis on 01/21/2019.
//  Copyright (c) 2019 Francis. All rights reserved.
//
//  Icons made by (https://www.flaticon.com/authors/freepik) Freepik from (https://www.flaticon.com/)
//  www.flaticon.com is licensed by (http://creativecommons.org/licenses/by/3.0/) Creative Commons BY 3.0
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

