//
//  CategoryDTO.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct MediaCategoryDTO: Codable {
    let id: Int
    let name: String
}

extension MediaCategoryDTO {
    func toDomain() -> Activity {
                return Activity(id: id,
                                title: name,
                                type: ActivityType(rawValue: id) ?? .unknowned,
                                url: nil,
                                coordinate: nil,
                                subActivities: nil)
    }
}
