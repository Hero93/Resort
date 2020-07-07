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

extension NewsWordpressDTO {
    
    func toDomain() -> News {
        return News(id: id,
        date: dateFormatter.date(from: date),
        title: title.rendered,
        content: content.rendered)
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    return formatter
}()
