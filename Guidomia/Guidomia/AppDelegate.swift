//
//  AppDelegate.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: GuidomiaViewController(model: nil))
        window?.makeKeyAndVisible()
        
        return true
    }


}

