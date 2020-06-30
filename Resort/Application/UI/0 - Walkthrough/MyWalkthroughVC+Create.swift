//
//  NavigationManager.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 12/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

// MARK: - Factory method

extension MyWalkthroughVC {
    
    static func create() -> MyWalkthroughVC {

        // Get view controllers and build the walkthrough

        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        let walkthroughVC = storyboard.instantiateViewController(withIdentifier: "walk") as! MyWalkthroughVC
        let pageOne = storyboard.instantiateViewController(withIdentifier: "walk1")
        let pageTwo = storyboard.instantiateViewController(withIdentifier: "walk2")
        let pageThree = storyboard.instantiateViewController(withIdentifier: "walk3")

        // Attach the pages to the master

        walkthroughVC.add(viewController: pageOne)
        walkthroughVC.add(viewController: pageTwo)
        walkthroughVC.add(viewController: pageThree)
        
        return walkthroughVC
    }
}
