//
//  Array+Unique.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 18/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

extension Array where Element : Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}
