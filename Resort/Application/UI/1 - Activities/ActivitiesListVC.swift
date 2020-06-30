//
//  ActivitiesListVC.swift
//  Gattarella
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 e-Gate. All rights reserved.
//

import UIKit

struct Activity {
    let icon: Data
    let title: String
    let url: URL
    let subActivities: [Activity]?
}

class ActivityListVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private var activitiesTableView: UITableView! {
        didSet {
            activitiesTableView.dataSource = self
            activitiesTableView.delegate = self
        }
    }
    
    // I need a way to transfor models to view models
    
    var viewModels: [ActivityViewModel]?
    
    // MARK: - View lifecycle
    
//    static func create(with viewModel: MoviesListViewModel,
//                       posterImagesRepository: PosterImagesRepository?) -> MoviesListViewController {
//        let view = MoviesListViewController.instantiateViewController(Bundle(for: Self.self).resource)
//        view.viewModel = viewModel
//        view.posterImagesRepository = posterImagesRepository
//        return view
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewModels = activities.map { ActivityViewModel(activity: $0) }
    }
}

// MARK: - UITableViewDataSource

extension ActivityListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowViewModel = self.viewModels?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withClass: ActivityTableViewCell.self, at: indexPath)
        if let rowViewModel = rowViewModel {
            cell.setup(with: rowViewModel)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ActivityListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
}
