//
//  MainTabBarController.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

enum TabBarElement: Int {
    case activities = 0
    case news
    case getInTouch
    case qrCode
    
    var title: String {
        switch self {
        case .activities:
            return NSLocalizedString("tabbar.title.activities", comment: "")
        case .news:
            return NSLocalizedString("tabbar.title.news", comment: "")
        case .getInTouch:
            return NSLocalizedString("tabbar.title.get_in_touch", comment: "")
        case .qrCode:
            return NSLocalizedString("tabbar.title.qr_code", comment: "")
        }
    }
    
    var icon: UIImage {
        switch self {
        case .activities:
            return UIImage(named: "activities")!
        
        case .news:
            return UIImage(named: "notice")!
        
        case .getInTouch:
            return UIImage(named: "contacts")!
        
        case .qrCode:
            return UIImage(named: "qr_code")!
        }
    }
}

/// A UITabBarController subclass that sets up our main coordinators as each of the five app tabs.
class MainTabBarController: UITabBarController {

    // Every tab has is own coordinator
    
    let activities = ActivitiesCoordinator()
    let notice = NewsCoordinator()
    let getInTouch = GetInTouchCoordinator()
    let qrCode = QRCodeCoordinator()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [activities.navigationController,
                           notice.navigationController,
                           getInTouch.navigationController,
                           qrCode.navigationController]
        
        //self.selectedIndex = TabBarElement.home.rawValue
        self.tabBar.tintColor = UIColor(named: "selectedTabTint")
        self.tabBar.unselectedItemTintColor = UIColor(named: "unselectedTabTint")
        
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
    }
}
