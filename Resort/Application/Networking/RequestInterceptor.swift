//
//  RequestInterceptor.swift
//  BeResponsible
//
//  Created by Luca LG. Gramaglia on 26/03/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import Alamofire

final class RequestInterceptor: Alamofire.RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var urlRequest = urlRequest
                
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(APIRouter.baseURLString),
            let basicToken = MyUserDefaults.basicToken  {
            urlRequest.setValue("Basic \(basicToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        
        #if DEBUG
        print(urlRequest.urlRequest?.allHTTPHeaderFields)
        #endif
        
        completion(Result.success(urlRequest))
    }
    
    // MARK: - RequestRetrier
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            /// The request did not fail due to a 401 Unauthorized response.
            /// Return the original error and don't retry the request.
            return completion(.doNotRetryWithError(error))
        }
    }
}
