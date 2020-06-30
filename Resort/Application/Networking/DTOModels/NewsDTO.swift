//
//  NewsDTO.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct NewsWordpressDTO: Codable {
    let id: Int
    let date: String
    let dateGmt: String
    let type: String
    let link: String?
    let title: Title
    let content: Content
    let excerpt: Content

    enum CodingKeys: String, CodingKey {
        case id, date
        case dateGmt = "date_gmt"
        case type, link, title, content, excerpt
    }
}

struct Title: Codable {
    let rendered: String
}

struct Content: Codable {
    let rendered: String
}

struct NewsWordpressDTOMapper {
    static func map(_ dto: NewsWordpressDTO) -> News {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return News(id: dto.id,
                    date: dateFormatter.date(from: dto.date),
                    title: dto.title.rendered,
                    content: dto.content.rendered)
    }
}
