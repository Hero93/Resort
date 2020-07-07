//
//  LocalJsonActivityListLoader.swift
//  Resort
//
//  Created by Luca Gramaglia on 16/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct LocalJsonActivityListLoader: ActivityListLoader {
    
    func load(completion: (Result<[Activity], Error>) -> Void) {
                
        guard let jsonUrl = Bundle.main.url(forResource: "activities", withExtension: "json") else {
            completion(.failure(CustomError(message: "Can't find 'activities.json'")))
            return
        }
        
        guard let jsonData = try? Data(contentsOf: jsonUrl) else {
            completion(.failure(CustomError(message: "Can't read 'activities.json' content")))
            return
        }
                
        guard let activitiesDTO = try? JSONDecoder().decode([LocalMediaDTO].self, from: jsonData) else {
                completion(.failure(CustomError(message: "Can't parse 'activities.json' content")))
            return
        }
                
        let activities = activitiesDTO.map { $0.toDomain() }
        completion(.success(activities))
    }
}
