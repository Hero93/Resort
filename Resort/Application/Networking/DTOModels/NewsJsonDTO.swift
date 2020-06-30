//
//  NewsJsonDTO.swift
//  Resort
//
//  Created by Luca Gramaglia on 29/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct NewsJsonDTO: Codable {
    let id: Int
    let date: String
    let title: String
    let content: String
}

struct NewsJsonDTOMapper {
    
    static func map(_ dto: NewsJsonDTO) -> News {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return News(id: dto.id,
                    date: dateFormatter.date(from: dto.date),
                    title: dto.title,content: dto.content)
    }
}
