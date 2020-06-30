//
//  Bundle.swift
//  UniversityApp
//
//  Created by Luca LG. Gramaglia on 25/01/2019.
//  Copyright © 2019 Luca LG. Gramaglia. All rights reserved.
//

import Foundation

extension Bundle {
    var displayName: String {
        let name = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        return name ?? object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
    }
}
