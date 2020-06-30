//
//  CoordinatedNavigationController.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

/// A navigation controller that is aware of its coordinator. This is used extremely rarely through UIResponder-Coordinated.swift, for when we need to find the coordinator responsible for a specific view.
class CoordinatedNavigationController: UINavigationController {
    weak var coordinator: Coordinator?
}
