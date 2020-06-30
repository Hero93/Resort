//
//  NewsViewModel.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class NewsListViewModel: NSObject {
    let title = Observable<String>(value: "Loading")
    var isLoading = Observable<Bool>(value: false)
    let isTableViewHidden = Observable<Bool>(value: false)
    let rowViewModels = Observable<[RowViewModel]>(value: [])
}
