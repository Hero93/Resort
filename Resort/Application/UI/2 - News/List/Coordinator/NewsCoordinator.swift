//
//  NoticeCoordinator.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class NewsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        
        let newsListVC = NewsListVC.instantiate(fromAppStoryboard: .News)
        newsListVC.tabBarItem = UITabBarItem(title: TabBarElement.news.title,
                                               image: TabBarElement.news.icon,
                                               tag: TabBarElement.news.rawValue)
        newsListVC.controller = NewsListController(newsListLoader: LocalJsonNewsListLoader())
        newsListVC.coordinator = self
        self.navigationController = UINavigationController(rootViewController: newsListVC)
        self.navigationController.isNavigationBarHidden = true
    }
    
    func openDetail(news: News) {
        let vc = NewsDetailVC.instantiate(fromAppStoryboard: .News)
        vc.viewModel = NewsDetailViewModel(news)
        vc.title = NSLocalizedString("news.detail.title", comment: "")
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController.present(nav, animated: true, completion: nil)
    }
}
