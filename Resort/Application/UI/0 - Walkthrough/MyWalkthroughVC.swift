//
//  MyWalkthrough.swift
//  BeResponsible
//
//  Created by Luca LG. Gramaglia on 26/03/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import BWWalkthrough

class MyWalkthroughVC: BWWalkthroughViewController {
        
    // MARK: - IBOutlets
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var startButtonWidthConstraint: NSLayoutConstraint! {
        didSet {
            startButtonWidthConstraint.constant = 0
        }
    }
    
    private static let startButtonWidth: CGFloat = 99
    
    // MARK: - IVars
        
    weak var coordinator: WalkthroughCoordinator?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        
        prevButton?.layer.borderWidth = 1
        prevButton?.layer.cornerRadius = 5
        prevButton?.layer.borderColor = UIColor.init(named: "appBackground")?.cgColor
        
        nextButton?.layer.borderWidth = 1
        nextButton?.layer.cornerRadius = 5
        nextButton?.layer.borderColor = UIColor.init(named: "buttonColor")?.cgColor
        nextButton?.layer.backgroundColor = UIColor.init(named: "buttonColor")?.cgColor
        
        startButton?.layer.cornerRadius = 5
        startButton.layer.backgroundColor = UIColor.init(named: "darkButton")?.cgColor
        
    }
    
    // MARK: - Private methods
    
    private func handleStartButtonVisibility(on pageNumber: Int) {
        
        guard let numberOfPages = pageControl?.numberOfPages else {
            startButtonWidthConstraint.constant = 0
            return
        }
        
        let lastPage = numberOfPages - 1
        startButtonWidthConstraint.constant = pageNumber == lastPage ? MyWalkthroughVC.startButtonWidth : 0
    }
    
    // MARK: - IBActions
    
    @IBAction func start(_ sender: Any) {
        coordinator?.didTapStartButton()
    }
}

// MARK: - BWWalkthroughViewController delegate

extension MyWalkthroughVC: BWWalkthroughViewControllerDelegate {
    
    func walkthroughPageDidChange(_ pageNumber: Int) {
        handleStartButtonVisibility(on: pageNumber)
    }
}
