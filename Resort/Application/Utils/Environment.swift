//
//  Environment.swift
//  DifferentEnviromentsTestApp
//
//  Created by Luca LG. Gramaglia on 19/12/2018.
//  Copyright © 2018 Luca LG. Gramaglia. All rights reserved.
//

import UIKit

public enum PlistKey: String {
    case httpProtocol = "http_protocol"
    case serverURL = "server_url"
}

public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .serverURL:
            return infoDict[PlistKey.serverURL.rawValue] as! String
        case .httpProtocol:
            return infoDict[PlistKey.httpProtocol.rawValue] as! String
        }
    }
}
