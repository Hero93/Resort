//
//  GetInTouchViewModel.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct GetInTouchViewModel {
    
    var isLoading = Observable<Bool>(value: false)
    private let getInTouchInfo: GetInTouchInfo?
 
    init(getInTouchInfo: GetInTouchInfo?) {
        self.getInTouchInfo = getInTouchInfo
    }
}

extension GetInTouchViewModel {
    
    var address: String {
        guard let getInTouchInfo = getInTouchInfo else { return "" }
        return "\(getInTouchInfo.name.uppercased()) \n\(getInTouchInfo.address)"
    }
    
    var phoneNumbers: String {
        guard let getInTouchInfo = getInTouchInfo else { return "" }
        return String(getInTouchInfo.phoneNumbers.flatMap({"\($0)\n"}))
    }
    
    var email: String {
        guard let getInTouchInfo = getInTouchInfo else { return "" }
        return getInTouchInfo.email
    }
    
    var vatNumber: String {
        guard let getInTouchInfo = getInTouchInfo else { return "" }
        return getInTouchInfo.vatNumber
    }
}
