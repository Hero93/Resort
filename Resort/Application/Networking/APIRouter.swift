//
//  APIRouter.swift
//  BuyTheWay
//
//  Created by Luca LG. Gramaglia on 15/03/2018.
//  Copyright © 2018 Luca LG. Gramaglia. All rights reserved.
//

import Alamofire

/// A "Router" contains simple, static data such as paths, parameters and common headers of the app's webservice

enum APIRouter : URLRequestConvertible {
    
    static let baseURLString = "http://cloudfiles.lucagramaglia.it/wp-json/wp/v2/"//APIClient.getServerURL().absoluteString
    
    // 
    
    //MARK: Account
    
    case getMediaCategories
    case getMediaList(MediaListRequest)
    case getMedia(MediaRequest)
    case getNews
    case getVillageInfo(Int)
    
    // MARK: - HTTPMethod
    
    private var method: HTTPMethod {
        switch self {
            
        case .getMediaCategories,
             .getMediaList,
             .getMedia,
             .getNews,
             .getVillageInfo:
            return .get
        }
    }
    
    // MARK: - Path
    
    private var path: String {
        switch self {
            
        case .getMediaCategories:
            return "mediacategory"
            
        case .getMediaList(let request):
            return "media?parent=\(request.villageId)"
            
        case .getMedia(let request):
            return "media?parent=\(request.villageId)&include=\(request.mediaId)"
            
        case .getNews:
            return "posts/?author=4&filter[orderby]=wpdb_fieldname&order=desc"
            
        case .getVillageInfo(let id):
            return "portfolio_page/\(id)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getNews,
             .getVillageInfo,
             .getMediaList,
             .getMedia,
             .getMediaCategories:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let completeUrl = APIRouter.baseURLString.appending(path)
        print(completeUrl)
        
        var urlRequest: URLRequest
        if let completeUrlWithoutPercent = completeUrl.removingPercentEncoding, !completeUrlWithoutPercent.isEmpty {
            urlRequest = try URLRequest(url: completeUrlWithoutPercent.asURL())
        } else {
            urlRequest = try URLRequest(url: completeUrl.asURL())
        }
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            
            print(parameters)
            
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return try Alamofire.URLEncoding.default.encode(urlRequest, with: nil)
    }
}
