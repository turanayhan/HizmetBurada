//
//  AppDelegate.swift
//  Hizmet Burada
//
//  Created by turan on 2.11.2023.
//

import UIKit
import FirebaseCore


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        setStartApp()
        return true
    }


}

extension AppDelegate {
    func setStartApp(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        AppNavigation(window: window!).startApp()
    }
}
