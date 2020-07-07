//
//  RemoteActivityListLoader.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class RemoteActivityListLoader: ActivityListLoader {

    func load(completion: @escaping (Result<[Activity], Error>) -> Void) {
        
        APIClient.shared.getMediaCategories { result in
            
            // get categories
            
            switch result {
            
            case .success(let categoriesDTO):
                                                                
                APIClient.shared.getMediaList(request: MediaListRequest()) { result in
                    
                    // get media list
                    
                    switch result {
                    
                    case .success(let mediaDTOList):
                                                                        
                        let activities: [Activity] = mediaDTOList.compactMap { mediaDTO -> Activity? in
                            
                            let mediaCategoryDTO: MediaCategoryDTO? = categoriesDTO.filter { $0.id == mediaDTO.mediacategory.first }.first
                            if let mediaCategoryDTO = mediaCategoryDTO {
                                return mediaCategoryDTO.toDomain()
                            } else {
                                return nil
                            }
                        }
                        
                        var uniqueActivities = activities.unique
                        
                        for (index, activity) in uniqueActivities.enumerated() {
                            let filteredMediaDTOList = mediaDTOList.filter { $0.mediacategory.first == activity.id }
                            let activityList = filteredMediaDTOList.map { $0.toDomain() }
                            uniqueActivities[index].subActivities = activityList
                        }
                                                
                        completion(.success(uniqueActivities))
                    
                    case .error(let wsError):
                        completion(.failure(wsError))
                    }
                }
                            
            case .error(let wsError):
                print("wsError: \(wsError)")
                completion(.failure(wsError))
            }
        }
    }    
}
