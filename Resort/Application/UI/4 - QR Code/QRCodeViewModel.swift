//
//  QRCodeViewModel.swift
//  Resort
//
//  Created by Luca Gramaglia on 18/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class QRCodeViewModel: NSObject {
    
    var isLoading = Observable<Bool>(value: false)
    var titleText: String = NSLocalizedString("qrcode.title", comment: "")
    var descriptionText: String = NSLocalizedString("qrcode.description", comment: "")
    var confirmButtonText: String = NSLocalizedString("qrcode.confirm_button", comment: "")
    var activityToOpen = Observable<Activity?>(value: nil)
    
    private var loader: MediaLoader
    
    init(loader: MediaLoader) {
        self.loader = loader
    }
    
    // MARK: - Public methods
    
    func getMedia(with mediaId: Int) {
                
        self.isLoading.value = true

        loader.load(id: mediaId) { [weak self] result in
            switch result {
            case .success(let activity):
                self?.isLoading.value = false
                self?.activityToOpen.value = activity

            case .failure(let error):
                print("error: \(error)")
                self?.isLoading.value = false
            }
        }
    }
}
