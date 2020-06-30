//
//  RemoteNewsListLoader.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class RemoteNewsListLoader: NewsListLoader {
    
    func load(completion: @escaping (Result<[News], Error>) -> Void) {
        
        APIClient.shared.getNews { result in
            switch result {
            
            case .success(let newsDTO):
                let news = newsDTO.map { NewsWordpressDTOMapper.map($0) }
                completion(.success(news))
            
            case .error(let wsError):
                print("wsError: \(wsError)")
                completion(.failure(wsError))
            }
        }
    }
}
