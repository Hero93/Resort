//
//  ActivitiesCoordinator.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class ActivitiesCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        
        super.init()
        
        let activitiesContainerVC = ActivitiesContainerVC.instantiate(fromAppStoryboard: .Activities)
        activitiesContainerVC.tabBarItem = UITabBarItem(title: TabBarElement.activities.title,
                                               image: TabBarElement.activities.icon,
                                               tag: TabBarElement.activities.rawValue)

        // list
        
        let listVC = ActivityListVC.create(with: ActivityListController(activityListLoader: LocalJsonActivityListLoader()))
        let listNav = UINavigationController(rootViewController: listVC)
        let coordinator = ActivityListCoordinator(navigationController: listNav)
        listVC.coordinator = coordinator
        childCoordinators.append(coordinator)
        listVC.navigationController?.isNavigationBarHidden = true
        
        // map
        
        let mapVC = ActivitiesMapVC.instantiate(fromAppStoryboard: .Activities)
        let mapNav = UINavigationController(rootViewController: mapVC)
        mapVC.controller = ActivitiesMapController(loader: LocalJsonActivityListLoader())
        mapVC.coordinator = ActivityMapCoordinator(navigationController: mapNav)
        mapVC.navigationController?.isNavigationBarHidden = true
        
        activitiesContainerVC.activitiesListNav = listNav
        activitiesContainerVC.activitiesMapNav = mapNav
        activitiesContainerVC.coordinator = self
        self.navigationController = UINavigationController(rootViewController: activitiesContainerVC)
        activitiesContainerVC.navigationController?.isNavigationBarHidden = true
        
        self.navigationController.delegate = self
    }
}
