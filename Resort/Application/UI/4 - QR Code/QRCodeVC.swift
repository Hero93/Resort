//
//  QRCodeVC.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class QRCodeVC: UIViewController {
    
    // TODO: create a view model + controller + loader
    
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel?.titleText
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = viewModel?.descriptionText
        }
    }
    @IBOutlet private weak var confirmButton: DarkBlueButton! {
        didSet {
            confirmButton.setTitle(viewModel?.confirmButtonText, for: .normal)
        }
    }
    
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    // MARK: - IVars
    
    private lazy var qrReaderManager = QRReaderManager(parentVC: self)
    var viewModel: QRCodeViewModel?
    weak var coordinator: QRCodeCoordinator?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qrReaderManager.delegate = self
        initBinding()
    }
    
    // MARK: - Private methods
    
    private func initBinding() {
        
        viewModel?.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.activityIndicatorView.startAnimating()
            } else {
                self?.activityIndicatorView.stopAnimating()
            }
        }
        
        viewModel?.activityToOpen.addObserver { [weak self] activityToOpen in
            guard let media = activityToOpen else { return }
            self?.open(media)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func openQrReader(_ sender: Any) {
        qrReaderManager.scan()
    }
    
    // MARK: - Web services
    
    private func getMedia(id: Int) {
        viewModel?.getMedia(with: id)
    }
    
    private func open(_ activity: Activity) {
        guard let url = activity.url else { return }
        self.coordinator?.openMedia(with: url, title: activity.title)
    }
}

// MARK: - QRReaderManagerDelegate

extension QRCodeVC: QRReaderManagerDelegate {
    
    func didFinish(with qrData: QRData) {
        guard let mediaId = Int(qrData.mediaId) else { return }
        getMedia(id: mediaId)
    }
    
    func didFinishWithError() {
        print("didFinishWithError")
    }
}
