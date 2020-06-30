//
//  DeviceUtility.swift
//  Bepooler
//
//  Created by Luca LG. Gramaglia on 21/12/2017.
//  Copyright © 2017 valentinoMalloggia. All rights reserved.
//

import UIKit

struct Device : Codable {
    let deviceUID: String = MyUserDefaults.applicationUniqueIdentifier!
    let deviceType: Int = 1 // iOS
    
    private enum CodingKeys: String, CodingKey {
        case deviceUID = "DeviceUID"
        case deviceType = "DeviceType"
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict[CodingKeys.deviceUID.rawValue] = self.deviceUID
        dict[CodingKeys.deviceType.rawValue] = self.deviceType
        return dict
    }
}

class DeviceUtils {
    
    static func getDevice() -> Device {
        return Device()
    }
    
    static func getDeviceSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    static func isiPhone5OrLess() -> Bool {
        return getDeviceSize().height <= 568
    }
    
    static func isiPhoneX() -> Bool {
        if #available(iOS 11.0, *) {
            if let top = UIApplication.shared.keyWindow?.safeAreaInsets.top, top > 0 {
                return true
            }
        }
        return false
    }
}
