//
//  ActivityListCoordinator.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 16/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class ActivityListCoordinator: NSObject, Coordinator {

    // MARK: - IVars
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController = UINavigationController()

    private var subactivities: [Activity]?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func open(with subactivities: [Activity], parent: Activity) {
                      
        self.subactivities = subactivities
        
        let vc = SubActivitiesVC.instantiate(fromAppStoryboard: .Activities)
        vc.rowViewModels = ActivityListController.viewModels(from: subactivities)
        vc.activites = subactivities
        vc.iconImage = parent.type.icon
        vc.headerTitle = parent.title
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func detailsDidGoBackToList() {
        self.navigationController.popViewController(animated: true)
    }
    
    func openMedia(with url: URL, title: String) {
        
        let wkWebViewVC = WKWebViewVC.instantiate(fromAppStoryboard: .Main)
        wkWebViewVC.navBarTitle = title
        wkWebViewVC.load = .url(url)
        let nav = UINavigationController(rootViewController: wkWebViewVC)
        self.navigationController.present(nav, animated: true, completion: nil)
    }
}
