//
//  NewsDetailVC.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class NewsDetailVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .getCustomFont(.montserratBold, size: 16.0)
            titleLabel.textColor = UIColor(named: "text")!
        }
    }
    @IBOutlet private var contentTextView: UITextView! {
        didSet {
            contentTextView.backgroundColor = .clear
        }
    }
    
    // MARK: - IVars
    
    var viewModel: NewsDetailViewModel?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewContents()
    }
    
    // MARK: - Class methods
    
    private func setViewContents() {
        self.titleLabel.text = viewModel?.title
        self.contentTextView.text = viewModel?.description
    }
}
