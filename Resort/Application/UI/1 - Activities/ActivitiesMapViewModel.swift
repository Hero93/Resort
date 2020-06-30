//
//  ActivitiesMapViewModel.swift
//  Resort
//
//  Created by Luca Gramaglia on 21/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class ActivitiesMapViewModel: NSObject {
    let title = Observable<String>(value: "Loading")
    var isLoading = Observable<Bool>(value: false)
    let activityMapViewModels = Observable<[ActivityMapViewModel]>(value: [])
}
