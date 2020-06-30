//
//  QRCodeLoader.swift
//  Resort
//
//  Created by Luca Gramaglia on 18/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

protocol MediaLoader {
    func load(id: Int, completion: @escaping (Result<Activity, Error>) -> Void)
}
