//
//  NewsJsonDTO.swift
//  Resort
//
//  Created by Luca Gramaglia on 29/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct LocalNewsDTO: Codable {
    let id: Int
    let date: String
    let title: String
    let content: String
}

extension LocalNewsDTO {
    func toDomain() -> News {        
        return News(id: id,
                    date: dateFormatter.date(from: self.date),
                    title: title,
                    content: content)
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    return formatter
}()
