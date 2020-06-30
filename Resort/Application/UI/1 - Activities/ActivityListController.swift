//
//  ActivitiesListController.swift
//  Resort
//
//  Created by Luca Gramaglia on 15/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class ActivityListController: NSObject {
    
    // MARK: - IVars
    
    let viewModel: ActivityListViewModel
    let activityListLoader: ActivityListLoader
    
    private var activities: [Activity]?
    
    // MARK: - Init
    
    init(viewModel: ActivityListViewModel = ActivityListViewModel(), activityListLoader: ActivityListLoader) {
        self.viewModel = viewModel
        self.activityListLoader = activityListLoader
    }
    
    func start() {
        
        self.viewModel.isLoading.value = true
        self.viewModel.isTableViewHidden.value = true
        self.viewModel.title.value = "Loading..."
        
        activityListLoader.load { [weak self] result in
            
            switch result {
            case .success(let activities):
                self?.viewModel.isLoading.value = false
                self?.viewModel.isTableViewHidden.value = false
                self?.buildViewModels(activities: activities)
                self?.activities = activities
                
            case .failure(let error):
                print("error: \(error)")
                self?.viewModel.isLoading.value = false
                self?.viewModel.isTableViewHidden.value = true
            }
        }
    }
    
    // MARK: - Data source
    
    private func buildViewModels(activities: [Activity]) {
        self.viewModel.rowViewModels.value = ActivityListController.viewModels(from: activities)
    }
    
    static func viewModels(from activities: [Activity]) -> [ActivityRowViewModel] {
        let activityViewModels = activities.map { activity -> ActivityRowViewModel in
            
            var hasSubActivities: Bool = false
            if let subActivities = activity.subActivities, subActivities.count > 0 {
                hasSubActivities = true
            }
            let activityVM = ActivityRowViewModel(icon: activity.type.icon, title: activity.title, hasSubActivities: hasSubActivities)
            return activityVM
        }
        return activityViewModels
    }
    
    func getSubActivities(for index: Int) -> [Activity]? {
        return activities?[index].subActivities
    }
    
    func getActivity(for index: Int) -> Activity? {
        return activities?[index]
    }
}
