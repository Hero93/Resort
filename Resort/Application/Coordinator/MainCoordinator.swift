//
//  MainCoordinator.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 12/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, Walkthroughing  {
    
    // MARK: - IVars
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func start() {
        navigationController.delegate = self
        
        // TODO: walkthrough should be display only the first time the app is opened.
        let child = WalkthroughCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
    
    func didTapStartButton() {
        MainCoordinator.setViewControllerAsRoot(MainTabBarController())
    }
    
    static func setViewControllerAsRoot(_ vc: UIViewController) {
        
        guard let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController  else {
                return
        }
        
        vc.view.frame = rootViewController.view.frame
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = vc
        }, completion: { _ in })
    }
    
    static func removeViewControllerFromNavigationController (_ vc: UIViewController) {
        vc.navigationController?.viewControllers.removeAll(where: { vc == $0 })
    }
}

// MARK: - UINavigationControllerDelegate

extension MainCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        
    }
}
