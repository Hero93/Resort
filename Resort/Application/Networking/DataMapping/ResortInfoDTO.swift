//
//  ResortInfoDTO.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 16/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct ResortInfoDTO: Codable {
    let name: String
    let address: String
    let phoneNumbers: [String]
    let email : String
    let vatNumber: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case address
        case phoneNumbers = "phone_numbers"
        case email
        case vatNumber = "vat_number"
    }
}

extension ResortInfoDTO {
    
    func toDomain() -> ResortInfo {
        return ResortInfo(name: name,
                              address: address,
                              phoneNumbers: phoneNumbers,
                              email: email,
                              vatNumber: vatNumber)
    }
}
