//
//  String+HtmlAttributedString.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

extension String {
    
    func htmlAttributedString(font: UIFont, color: UIColor? = .black) -> NSMutableAttributedString {
         
         let boldString =
         "<span style='font-family: \(font.fontName); font-size: \(font.pointSize)px;'>\(self)</span>"
         
         guard let data = boldString.data(using: String.Encoding.unicode, allowLossyConversion: true) else { return NSMutableAttributedString() }
         
         do {
             return try NSMutableAttributedString(data: data, options:
                 [.documentType: NSAttributedString.DocumentType.html,
                  .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
         } catch {
             return NSMutableAttributedString()
         }
     }
}
