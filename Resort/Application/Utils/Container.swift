//
//  Container.swift
//  BePooler
//
//  Created by Luca LG. Gramaglia on 19/01/17.
//  Copyright © 2017 valentinoMalloggia. All rights reserved.
//

import UIKit

protocol Container {
    var parentView: UIView? {get}
}

/* 
 * This protocol is used by the master view controller, the view controller that implements this protocol, to
 * add or remove a child view controller inside its view.
 */

extension Container where Self: UIViewController {

    func add(asChildViewController viewController: UIViewController, fullScreen: Bool) {
        
        guard let viewToUse : UIView = parentView else { return }
        
        if fullScreen {

            // Hide Navigation Bar (if present)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
            // Hide UITabBar (if present)
            if let tabBar = self.tabBarController {
                //ViewUtils.setTabBarVisible(tabBar, view: viewToUser, visible: false, animated: true)
            }
        }
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        viewToUse.addSubview(viewController.view)
                
        // Configure Child View
        viewController.view.frame = viewToUse.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController, fullScreen: Bool) {
        remove(asChildViewController: viewController, fullScreen: fullScreen, showTabBar: true)
    }
    
    func remove(asChildViewController viewController: UIViewController, fullScreen: Bool, showTabBar: Bool) {
        
        if fullScreen {
            
            // Show Navigation Bar (if present)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            
            // Show UITabBar (if present)
            if showTabBar {
                if let tabBar = self.tabBarController {
                    //ViewUtils.setTabBarVisible(tabBar, view: self.view, visible: true, animated: true)
                }
            }
        }
        
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
}
