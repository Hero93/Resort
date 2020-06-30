//
//  ActivityService.swift
//  Resort
//
//  Created by Luca Gramaglia on 15/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

protocol ActivityListLoader {
    func load(completion: @escaping (Result<[Activity], Error>) -> Void)
}

struct CustomError: Error {
    var message: String
}
