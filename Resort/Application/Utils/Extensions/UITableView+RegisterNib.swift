//
//  UITableView.swift
//  BePooler
//
//  Created by Luca LG. Gramaglia on 15/02/17.
//  Copyright © 2017 valentinoMalloggia. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerNib(forCellClass cellClass: UITableViewCell.Type) {
        let className = String(describing: cellClass)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
}
