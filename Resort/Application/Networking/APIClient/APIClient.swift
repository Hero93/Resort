//
//
//  APIClient.swift
//  BuyTheWay
//
//  Created by Luca LG. Gramaglia on 15/03/2018.
//  Copyright © 2018 Luca LG. Gramaglia. All rights reserved.
//

import Alamofire

enum APIResult<T, E: Error> {
    case success(T)
    case error(E)
}

enum APIResultWithNoData<E: Error> {
    case success
    case error(E)
}

enum WsError : Error {
    case webServiceMessage(String)
    case generic
    case noContent
    case forbidden
    case conflict
    case unauthorized
    case notFound
}

struct Credentials: Codable {
    let username : String
//    let password : String
    
    private enum CodingKeys: String, CodingKey {
        case username = "Username"
//        case password = "Password"
    }
}

class APIClient : NSObject {
    
    // MARK: - Properties
    
    static let shared = APIClient()
    static let clientID = "Resort"
    
    internal var isRefreshing = false
    private let lock = NSLock()
    
    private let sessionManager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        return Alamofire.Session(configuration: configuration, interceptor: RequestInterceptor())
    }()
        
    // MARK: - PerformRequest methods
    
    @discardableResult
    internal func performRequest<T:Decodable>(route:APIRouter,
                                              decoder: JSONDecoder = JSONDecoder(),
                                              completion: @escaping (APIResult<T, WsError>)->Void) -> DataRequest {
        
        decoder.dateDecodingStrategy = .custom(APIClient.customDateFormatter)
        
        print("----------- Calling Ws -------------- :")
        print("## \(String(describing: route.urlRequest?.url?.absoluteString))")
        
        return sessionManager.request(route).validate().responseDecodable(completionHandler: { (dataResponse: DataResponse<T, AFError>) in
            
            print("dataResponse (statusCode): \(String(describing: dataResponse.response?.statusCode) )")
            
            switch dataResponse.result {
            case .success(let value):
                completion(.success(value))
                
            case .failure(let error):
                
                print(error)
                
                guard let serverMessageError = APIClient.getServerErrorMessage(dataResponse.data) else {
                    completion(.error(APIClient.getWsError(dataResponse.response)))
                    return
                }
                
                if serverMessageError == "An error has occured, please, try again later." ||
                    serverMessageError == "Si è verificato un errore.\n Si prega di riprovare più tardi, grazie." {
                    completion(.error(APIClient.getWsError(dataResponse.response)))
                } else {
                    completion(.error(WsError.webServiceMessage(serverMessageError)))
                }
            }
            
            print("--------------------------------")
        })
    }
    
    @discardableResult
    internal func performRequestWithNoResponseData(route:APIRouter,
                                                   decoder: JSONDecoder = JSONDecoder(),
                                                   completion: @escaping (APIResultWithNoData<WsError>)->Void) -> DataRequest {
        
        print("----------- Calling Ws -------------- :")
        print("## \(String(describing: route.urlRequest?.url?.absoluteString))")
        
        return sessionManager.request(route).validate().responseJSON(completionHandler: { dataResponse in
            
            print("dataResponse (statusCode): \(String(describing: dataResponse.response?.statusCode) )")
            
            if dataResponse.response?.statusCode == 200 {
                completion(.success)
                
            } else {
                
                guard let serverMessageError = APIClient.getServerErrorMessage(dataResponse.data) else {
                    completion(.error(APIClient.getWsError(dataResponse.response)))
                    return
                }
                
                if serverMessageError == "An error has occured, please, try again later."
                    || serverMessageError == "Si è verificato un errore.\n Si prega di riprovare più tardi, grazie." {
                    completion(.error(APIClient.getWsError(dataResponse.response)))
                } else {
                    completion(.error(WsError.webServiceMessage(serverMessageError)))
                }
            }
        })
    }
}

// MARK: - Utility methods

extension APIClient {
    
    private static func getWsError(_ response: HTTPURLResponse?) -> WsError {
        
        if response?.statusCode == 204 {
            return .noContent
        } else if response?.statusCode == 403 {
            return .forbidden
        } else if response?.statusCode == 404 {
            return .notFound
        } else if response?.statusCode == 409 {
            return .conflict
        } else {
            return .generic
        }
    }
    
    private static func getServerErrorMessage(_ responseData: Data?) -> String? {
        
        guard let serverResponseData = responseData else {
            return nil
        }
        
        let json = try? JSONSerialization.jsonObject(with: serverResponseData, options: .allowFragments)
        #if DEBUG
        print(json ?? "")
        #endif
        if let json = json as? [String:Any] {
            return json["ErrorMessage"] as? String
        }
        return NSLocalizedString("Si è verificato un errore, riprovare più tardi.", comment: "")
    }
    
    static let customDateFormatter : ((Decoder) throws -> Date) = { (decoder) -> Date in
        
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        var date: Date? = nil
        
        let dateFormatterWithoutMilliseconds = DateFormatter.iso8601
        if let dateWithoutMilliseconds = dateFormatterWithoutMilliseconds.date(from: dateString) {
            date = dateWithoutMilliseconds
        } else {
            let dateFormatterWithMilliseconds = DateFormatter.iso8601WithMilliseconds
            date = dateFormatterWithMilliseconds.date(from: dateString)
        }
        
        guard let date_ = date else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
        }
        return date_
    }
    
    static func getStringDateFormattedForWs(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.string(from: date)
    }
    
    static func getCurrentLocaleStringDate(date: Date?, withTime: Bool? = false) -> String? {
        
        if let date = date {
            let df = DateFormatter()
            df.dateStyle = .medium
            if let withTime = withTime, withTime == true {
                df.timeStyle = .short
            }
            return df.string(from: date)
        }
        
        return nil
    }
    
    static func getServerURL() -> URL {
        let httpProtocol = Environment().configuration(.httpProtocol)
        let serverURL = Environment().configuration(.serverURL)
        return URL(string: "\(httpProtocol)://\(serverURL)")!
    }
}
