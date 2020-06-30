//
//  GetInTouchCoordinator.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class GetInTouchCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController = UINavigationController()
    
    
    init(navigationController: UINavigationController = UINavigationController()) {
                
        let getInTouchVC = GetInTouchVC.instantiate(fromAppStoryboard: .Main)
        getInTouchVC.controller = GetInTouchController(getInTouchLoader: LocalJsonGetInTouchLoader())
        getInTouchVC.tabBarItem = UITabBarItem(title: TabBarElement.getInTouch.title,
                                               image: TabBarElement.getInTouch.icon,
                                               tag: TabBarElement.getInTouch.rawValue)
        self.navigationController = UINavigationController(rootViewController: getInTouchVC)
        getInTouchVC.navigationController?.isNavigationBarHidden = true
    }
}
