//
//  APIClient+Account.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 23/10/2018.
//  Copyright © 2018 Luca LG. Gramaglia. All rights reserved.
//

import UIKit
import Alamofire

struct MediaRequest {
    let villageId: Int = 78
    let mediaId: Int
}

struct MediaListRequest {
    let villageId: Int = 78
}

extension APIClient {
    
    // MARK: - Media
    
    // MARK: Categories
    
    func getMediaCategories(completion: @escaping (APIResult<[MediaCategoryDTO], WsError>)->Void) {
        performRequest(route: .getMediaCategories, completion: completion)
    }
    
    func getMediaList(request: MediaListRequest, completion: @escaping (APIResult<[WordpressMediaDTO], WsError>)->Void) {
        performRequest(route: .getMediaList(request), completion: completion)
    }
    
    private func getMediaInternal(_ request: MediaRequest, completion: @escaping (APIResult<[WordpressMediaDTO], WsError>)->Void) {
        performRequest(route: .getMedia(request), completion: completion)
    }
    
    func getMedia(request: MediaRequest, completion: @escaping (APIResult<WordpressMediaDTO, WsError>)->Void) {
        
        APIClient.shared.getMediaInternal(request) { result in
            
            switch result {
            case .success(let mediaListDTO):
               
                guard let mediaDTO = mediaListDTO.first else {
                    completion(.error(.webServiceMessage("Problema con service")))
                    return
                }
                completion(.success(mediaDTO))
            
            case .error(let wsError):
                completion(.error(wsError))
            }
        }
    }
}
