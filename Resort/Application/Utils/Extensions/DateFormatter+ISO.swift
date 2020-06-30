//
//  DateFormatter+ISO.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 11/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

extension DateFormatter {
    
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    static let iso8601WithMilliseconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter
    }()
}
