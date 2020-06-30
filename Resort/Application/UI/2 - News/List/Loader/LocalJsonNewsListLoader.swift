//
//  LocalJsonNewsListLoader.swift
//  Resort
//
//  Created by Luca Gramaglia on 29/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class LocalJsonNewsListLoader: NewsListLoader {
    
    func load(completion: @escaping (Result<[News], Error>) -> Void) {
        
        guard let jsonUrl = Bundle.main.url(forResource: "news", withExtension: "json") else {
            completion(.failure(CustomError(message: "Can't find 'activities.json'")))
            return
        }
        
        guard let jsonData = try? Data(contentsOf: jsonUrl) else {
            completion(.failure(CustomError(message: "Can't read 'news.json' content")))
            return
        }
        
        guard let newsJsonDTO = try? JSONDecoder().decode([NewsJsonDTO].self, from: jsonData) else {
            completion(.failure(CustomError(message: "Can't parse 'news.json' content")))
            return
        }
        
        let news = newsJsonDTO.map { NewsJsonDTOMapper.map($0) }
        completion(.success(news))
    }
}
