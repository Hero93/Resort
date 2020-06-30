//
//  MyUserDefaults.swift
//
//  Created by Luca LG. Gramaglia on 15/06/16.
//  Copyright © 2016 Ubiqstudio. All rights reserved.
//

import Foundation
import MapKit

class MyUserDefaults {
    
    public static var basicToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "basicToken")
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "basicToken")
            defaults.synchronize()
        }
    }
    
    public static var applicationUniqueIdentifier : String? {
        get {
            return UserDefaults.standard.string(forKey: "ApplicationUniqueIdentifier")
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "ApplicationUniqueIdentifier")
            defaults.synchronize()
        }
    }
    
    public static var notFirstAppLauch : Bool {
        get {
            return UserDefaults.standard.bool(forKey: "firstAppLauch")
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "firstAppLauch")
            defaults.synchronize()
        }
    }
    
    static func removeAllValues() {
        basicToken = nil
        applicationUniqueIdentifier = nil
    }
}
