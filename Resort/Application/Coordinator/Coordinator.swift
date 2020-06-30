//
//  Coordinator.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 12/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
//    func start()
}
