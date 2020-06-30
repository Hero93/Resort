//
//  ActivityTableViewCell.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 15/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell, CellConfigurable {
    
    static let rowHeight: CGFloat = 80.0
    
    override var isSelected: Bool {
        didSet {
            shrink(down: true)
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 5
        }
    }
    @IBOutlet private var logoImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailButton: UIButton!
    
    // MARK: - Public methods
    
    func setup(with viewModel: RowViewModel) {
        
        guard let viewModel = viewModel as? ActivityRowViewModel else { return }
        
        logoImageView.image = viewModel.icon
        titleLabel.text = viewModel.title
        detailButton.isHidden = viewModel.hasSubActivities ? false : true
    }
    
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.6) {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            } else {
                self.transform = .identity
            }
        }
    }
}
