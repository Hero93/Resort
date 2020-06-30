//
//  QRCodeCoordinator.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class QRCodeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        
        let qrCodeVC = QRCodeVC.instantiate(fromAppStoryboard: .Main)
        qrCodeVC.tabBarItem = UITabBarItem(title: TabBarElement.qrCode.title,
                                               image: TabBarElement.qrCode.icon,
                                               tag: TabBarElement.qrCode.rawValue)
        qrCodeVC.coordinator = self
        qrCodeVC.viewModel = QRCodeViewModel(loader: RemoteMediaLoader())
        self.navigationController = UINavigationController(rootViewController: qrCodeVC)
        qrCodeVC.navigationController?.isNavigationBarHidden = true
    }
    
    func openMedia(with url: URL, title: String) {
        
        let wkWebViewVC = WKWebViewVC.instantiate(fromAppStoryboard: .Main)
        wkWebViewVC.navBarTitle = title
        wkWebViewVC.load = .url(url)
        let nav = UINavigationController(rootViewController: wkWebViewVC)
        self.navigationController.present(nav, animated: true, completion: nil)
    }
}
