//
//  SceneDelegate.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 11/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var coordinator: MainCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let windowScene = UIWindowScene(session: session, connectionOptions: connectionOptions)
        self.window = UIWindow(windowScene: windowScene)
        
        if #available(iOS 13.0, *) {
            // disable dark mode
            window?.overrideUserInterfaceStyle = .light
        }
        
        setRootViewController()
        
        self.window?.makeKeyAndVisible()
    }
    
    private func setRootViewController() {
        
        if MyUserDefaults.notFirstAppLauch == false {
            MyUserDefaults.notFirstAppLauch = true
            
            let navController = UINavigationController()
            coordinator = MainCoordinator(navigationController: navController)
            coordinator?.start()
            
            self.window?.rootViewController = navController
            
        } else {
            self.window?.rootViewController = MainTabBarController()
        }
    }
}
