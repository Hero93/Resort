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

struct MediaCategoryDTOMapper {
    
    static func mapToActivity(_ dto: MediaCategoryDTO) -> Activity {
        return Activity(id: dto.id, title: dto.name, type: ActivityType(rawValue: dto.id) ?? .unknowned, url: nil, coordinate: nil, subActivities: nil)
    }
}
