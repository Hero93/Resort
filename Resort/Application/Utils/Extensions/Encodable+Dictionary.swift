//
//  Encodable+Dictionary.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 11/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

extension Encodable {
    var dictionary: [String: Any]? {
        let decoder = JSONEncoder()
        decoder.dateEncodingStrategy = .formatted(.iso8601)
        guard let data = try? decoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

