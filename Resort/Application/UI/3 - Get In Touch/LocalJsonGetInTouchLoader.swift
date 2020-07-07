//
//  LocalJsonGetInTouchLoader.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct LocalJsonGetInTouchLoader: GetInTouchLoader {
    
    func load(completion: (Result<ResortInfo, Error>) -> Void) {
                
        guard let jsonUrl = Bundle.main.url(forResource: "contacts", withExtension: "json") else {
            completion(.failure(CustomError(message: "Can't find 'contacts.json'")))
            return
        }
        
        guard let jsonData = try? Data(contentsOf: jsonUrl) else {
            completion(.failure(CustomError(message: "Can't read 'contacts.json' content")))
            return
        }
                
        guard let dto = try? JSONDecoder().decode(ResortInfoDTO.self, from: jsonData) else {
                completion(.failure(CustomError(message: "Can't parse 'contacts.json' content")))
            return
        }
    
        completion(.success(dto.toDomain()))
    }
}
