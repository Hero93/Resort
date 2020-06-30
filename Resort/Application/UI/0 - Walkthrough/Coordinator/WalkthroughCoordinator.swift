//
//  WalkthroughCoordinator.swift
//  Resort
//
//  Created by Luca Gramaglia on 13/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

protocol Walkthroughing: AnyObject {
    func didTapStartButton()
}

class WalkthroughCoordinator: Coordinator {
        
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let myWalkthoughVC = MyWalkthroughVC.create()
        myWalkthoughVC.coordinator = self
        navigationController.pushViewController(myWalkthoughVC, animated: true)
    }
    
    func didTapStartButton() {
        parentCoordinator?.didTapStartButton()
    }
}
