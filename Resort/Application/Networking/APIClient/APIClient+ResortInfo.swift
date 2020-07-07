//
//  APIClient+VillageInfo.swift
//  Resort
//
//  Created by Luca Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

extension APIClient {

    // MARK: - Village info
    
    // MARK: Get
    
    static let villageId: Int = 79
    
    func getNews(id: Int = villageId, completion: @escaping (APIResult<[NewsWordpressDTO], WsError>)->Void) {
        performRequest(route: .getVillageInfo(id), completion: completion)
    }
}
