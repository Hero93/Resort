//
//  UIFont+Custom.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct CustomFont {
    let type: CustomFontType
}

enum CustomFontType : String {
    case montserratRegular = "Montserrat-Regular"
    case montserratMedium = "Montserrat-Medium"
    case montserratSemiBold = "Montserrat-SemiBold"
    case montserratBold = "Montserrat-Bold"
}

extension UIFont {
    
    static func getCustomFont(_ type: CustomFontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
