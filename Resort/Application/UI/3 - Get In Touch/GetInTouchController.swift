//
//  GetInTouchController.swift
//  Resort
//
//  Created by Luca Gramaglia on 16/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class GetInTouchController: NSObject {
    
    // MARK: - IVars
    
    var viewModel = Observable<GetInTouchViewModel?>(value: nil)
    let getInTouchLoader: GetInTouchLoader
    
    // MARK: - Init
    
    init(getInTouchLoader: GetInTouchLoader) {
        self.getInTouchLoader = getInTouchLoader
    }
    
    func start() {
                
        self.viewModel.value?.isLoading.value = true

        getInTouchLoader.load { [weak self] result in
            switch result {
            case .success(let getInTouchInfo):
                self?.viewModel.value?.isLoading.value = false
                self?.buildViewModel(with: getInTouchInfo)

            case .failure(let error):
                print("error: \(error)")
                self?.viewModel.value?.isLoading.value = false
            }
        }
    }
    
    // MARK: - Data source
    
    private func buildViewModel(with getInTouchInfo: GetInTouchInfo) {
        self.viewModel.value = GetInTouchViewModel(getInTouchInfo: getInTouchInfo)
    }
}
