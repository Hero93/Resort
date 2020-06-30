//
//  ActivityMapCoordinator.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 22/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit


class ActivityMapCoordinator: NSObject, Coordinator {

    // MARK: - IVars
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController = UINavigationController()
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func openMedia(with url: URL, title: String) {
        
        let wkWebViewVC = WKWebViewVC.instantiate(fromAppStoryboard: .Main)
        wkWebViewVC.navBarTitle = title
        wkWebViewVC.load = .url(url)
        let nav = UINavigationController(rootViewController: wkWebViewVC)
        self.navigationController.present(nav, animated: true, completion: nil)
    }
}
