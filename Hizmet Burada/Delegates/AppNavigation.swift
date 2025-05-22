//
//  AppNavigation.swift
//  Hizmet Burada
//
//  Created by turan on 15.11.2023.
//

import UIKit

public class DefaultNavigation: UINavigationController {
    
    var navigationBarBackgroundClear = true {
        didSet {
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.backgroundColor  = UIColor.clear
            self.navigationBar.shadowImage = UIImage()
        }
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return   .darkContent
    }
}



public class AppNavigation {
    private let window : UIWindow?
    init(window: UIWindow ) {
        self.window = window
    }
    func startApp() {
        
        let root = DefaultNavigation(rootViewController:SplashScreen())
        root.navigationBarBackgroundClear = true
        window!.rootViewController = root
        window!.makeKeyAndVisible()
    }
}
