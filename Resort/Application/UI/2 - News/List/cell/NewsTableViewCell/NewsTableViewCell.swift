//
//  NewsTableViewCell.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let rowHeight: CGFloat = 146.0

    // MARK: - IBOutlet
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 5
            containerView.layer.shadowOpacity = 1
            containerView.layer.shadowRadius = 2
            containerView.layer.shadowColor = UIColor(named: "shadow")?.cgColor
            containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        }
    }
    
    // MARK: - Public methods
    
    func setup(with viewModel: RowViewModel) {
        
        guard let newsRowViewModel = viewModel as? NewsRowViewModel else { return }
        
        dateLabel.text = newsRowViewModel.date
        titleLabel.text = newsRowViewModel.title
        descriptionLabel.attributedText = newsRowViewModel.description.htmlAttributedString(font: .getCustomFont(.montserratRegular, size: 12.0),
                                                                                            color: UIColor(named: "text")!)
    }
}
