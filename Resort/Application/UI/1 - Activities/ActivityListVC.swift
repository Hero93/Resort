//
//  ActivitiesListVC.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class ActivityListVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private var activitiesTableView: UITableView! {
        didSet {
            activitiesTableView.dataSource = self
            activitiesTableView.delegate = self
            activitiesTableView.registerNib(forCellClass: ActivityTableViewCell.self)
            activitiesTableView.separatorStyle = .none
            activitiesTableView.backgroundColor = .clear
        }
    }
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    // MARK: - IVars

    var controller: ActivityListController?
    var coordinator: ActivityListCoordinator?
    
    // MARK: - View lifecycle
    
    static func create(with controller: ActivityListController) -> ActivityListVC {

        let view = ActivityListVC.instantiate(fromAppStoryboard: .Activities)
        view.controller = controller
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBinding()
        controller?.start()
    }
    
    func initBinding() {
        controller?.viewModel.rowViewModels.addObserver(fireNow: false) { [weak self] (rowViewModels) in
            self?.activitiesTableView.reloadData()
        }

        controller?.viewModel.isTableViewHidden.addObserver { [weak self] (isHidden) in
            self?.activitiesTableView.isHidden = isHidden
        }

        controller?.viewModel.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.view.backgroundColor = .white
                self?.activityIndicatorView.startAnimating()
            } else {
                self?.view.backgroundColor = UIColor(named: "appBackground")!
                self?.activityIndicatorView.stopAnimating()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ActivityListVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.viewModel.rowViewModels.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let rowViewModel = self.controller?.viewModel.rowViewModels.value[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withClass: ActivityTableViewCell.self, at: indexPath)
        if let rowViewModel = rowViewModel{
            cell.setup(with: rowViewModel)
        }
        cell.selectionStyle = .default
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 0.4) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

// MARK: - UITableViewDelegate

extension ActivityListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ActivityTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex = indexPath.row
        
        if let rowViewModel = self.controller?.viewModel.rowViewModels.value[indexPath.row] as? ActivityRowViewModel {
            
            if rowViewModel.hasSubActivities {
            
                guard let subActivities = controller?.getSubActivities(for: rowIndex),
                    let parentActivity = controller?.getActivity(for: rowIndex) else { return }
                
                coordinator?.open(with: subActivities, parent: parentActivity)
            }
        }
    }
}
