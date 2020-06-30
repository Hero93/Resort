//
//  ActivitiesVC.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

enum ActivitiesControl: Int {
    case list = 0
    case map
    
    var title: String? {
        switch self {
        case .list:
            return NSLocalizedString("activities.segmented_control.list", comment: "").uppercased()
        case .map:
            return NSLocalizedString("activities.segmented_control.map", comment: "").uppercased()
        }
    }
}

class ActivitiesContainerVC: UIViewController, Container {

    // MARK: - IBOutlets
    
    @IBOutlet var customHeader: CustomHeader! {
        didSet {
            customHeader.title = NSLocalizedString("activities.header.title", comment: "")
            customHeader.subtitle = NSLocalizedString("activities.header.subtitle", comment: "")
        }
    }
    @IBOutlet var containerView: UIView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    // MARK: - IVars
    
    var activitiesListNav: UINavigationController?
    var activitiesMapNav: UINavigationController?
        
    weak var coordinator: ActivitiesCoordinator?
    
    // Container
    
    var parentView: UIView?
    
    fileprivate var currentSelectedSegment: ActivitiesControl = .list
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                            
        initSegmentedControl()
        handleContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func handleContainer() {
        parentView = self.containerView
        guard let segmentedControl = segmentedControl else { return }
        changeView(segmentedControl)
    }
    
    private func initSegmentedControl() {
        segmentedControl.setTitle(ActivitiesControl.list.title, forSegmentAt: ActivitiesControl.list.rawValue)
        segmentedControl.setTitle(ActivitiesControl.map.title, forSegmentAt: ActivitiesControl.map.rawValue)
    }
    
    // MARK: - IBActions
    
    @IBAction func changeView(_ sender: Any) {
        
        guard let selectedCard = ActivitiesControl(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        
        switch selectedCard {
        case .list:
            
            currentSelectedSegment = .list
            guard let activitiesListNav = activitiesListNav,
                let activitiesMapNav = activitiesMapNav else {
                    return
            }
            self.add(asChildViewController: activitiesListNav, fullScreen: false)
            self.remove(asChildViewController: activitiesMapNav, fullScreen: false)
            
        case .map:
            
            currentSelectedSegment = .map
            guard let activitiesListNav = activitiesListNav,
                let activitiesMapNav = activitiesMapNav else {
                    return
            }
            self.add(asChildViewController: activitiesMapNav, fullScreen: false)
            self.remove(asChildViewController: activitiesListNav, fullScreen: false)
        }
    }
}
