//
//  APIClient+News.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

extension APIClient {
    
    // MARK: - News
    
    // MARK: Get
    
    func getNews(completion: @escaping (APIResult<[NewsWordpressDTO], WsError>)->Void) {
        performRequest(route: .getNews, completion: completion)
    }
}
