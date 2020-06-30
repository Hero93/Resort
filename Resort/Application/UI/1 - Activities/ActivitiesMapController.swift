//
//  ActivitiesMapController.swift
//  Resort
//
//  Created by Luca Gramaglia on 21/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class ActivitiesMapController: NSObject {

    // MARK: - IVars
    
    let viewModel: ActivitiesMapViewModel
    private let activityListLoader: ActivityListLoader
    private var activities: [Activity]?
    
    // MARK: - Int
    
    init(loader: ActivityListLoader) {
        self.viewModel = ActivitiesMapViewModel()
        self.activityListLoader = loader
    }
    
    // MARK: - Public methods
    
    func start() {
        
        self.viewModel.isLoading.value = true
        self.viewModel.title.value = "Loading..."
        
        activityListLoader.load { [weak self] result in
            
            switch result {
            case .success(let activities):
                self?.viewModel.isLoading.value = false
                self?.buildViewModels(activities: activities)
                self?.activities = activities
                
            case .failure(let error):
                print("error: \(error)")
                self?.viewModel.isLoading.value = false
            }
        }
    }
    
    // MARK: - Data source
    
    private func buildViewModels(activities: [Activity]) {
        self.viewModel.activityMapViewModels.value = ActivitiesMapController.viewModels(from: activities)
    }
    
    private static func viewModels(from activities: [Activity]) -> [ActivityMapViewModel] {
        
        var viewModels: [[ActivityMapViewModel]] = [[ActivityMapViewModel]]()
        
        for activity in activities {
            
            let activityViewModels = activity.subActivities?.compactMap { activity -> ActivityMapViewModel? in
                                
                guard let coordinate = activity.coordinate else { return nil }
                return ActivityMapViewModel(id: activity.id,
                                            url: activity.url,
                                            coordinate: coordinate,
                                            image: activity.type.mapIcon,
                                            activityDescription: activity.title)
            }
            
            if let activityViewModels = activityViewModels {
                viewModels.append(activityViewModels)
            }
        }
        
        return  viewModels.flatMap { $0 }
    }
}
