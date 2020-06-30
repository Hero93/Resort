//
//  ResortInfoDTO.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 16/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct GetInTouchInfoDTO: Codable {
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

struct GetInTouchInfoDTOMapper {
    
    static func map(_ dto: GetInTouchInfoDTO) -> GetInTouchInfo {
        return GetInTouchInfo(name: dto.name,
                              address: dto.address,
                              phoneNumbers: dto.phoneNumbers,
                              email: dto.email,
                              vatNumber: dto.vatNumber)
    }
}
