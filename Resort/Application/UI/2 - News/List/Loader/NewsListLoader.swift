//
//  NewsLoader.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

protocol NewsListLoader {
    func load(completion: @escaping (Result<[News], Error>) -> Void)
}
