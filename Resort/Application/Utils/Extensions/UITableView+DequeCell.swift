//
//  UITableView+DequeCell.swift
//  StopCovid
//
//  Created by Luca LG. Gramaglia on 15/06/2020.
//  Copyright © 2020 Lunabee Studio. All rights reserved.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<CellType: UITableViewCell>(withClass cellClass: CellType.Type, at indexPath: IndexPath) -> CellType {
        let identifier = String(describing: cellClass)
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CellType
    }
}
