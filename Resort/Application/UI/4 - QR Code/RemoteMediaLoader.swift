//
//  RemoteQRCodeMediaLoader.swift
//  Resort
//
//  Created by Luca Gramaglia on 19/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class RemoteMediaLoader: MediaLoader {
    
    func load(id: Int, completion: @escaping (Result<Activity, Error>) -> Void) {
        
        let request = MediaRequest(mediaId: id)
        APIClient.shared.getMedia(request: request) { result in
                        
            switch result {
                
            case .success(let mediaDTO):
                print("\(mediaDTO)")
                completion(.success(mediaDTO.toDomain()))
            
            case .error(let wsError):
                print("\(wsError)")
                completion(.failure(wsError))
            }
        }
    }
}
