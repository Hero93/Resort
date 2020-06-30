//
//  GetInTouchLosder.swift
//  Resort
//
//  Created by Luca Gramaglia on 16/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

protocol GetInTouchLoader {
    func load(completion: (Result<GetInTouchInfo, Error>) -> Void)
}
