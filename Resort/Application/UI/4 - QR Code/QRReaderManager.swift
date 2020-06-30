//
//  QRReaderManager.swift
//  BeResponsible
//
//  Created by Luca LG. Gramaglia on 25/03/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import QRCodeReader
import MapKit

struct QRData {
    let mediaId: String
}

protocol QRReaderManagerDelegate {
    func didFinishWithError()
    func didFinish(with qrData: QRData)
}

class QRReaderManager: NSObject {
    
    // MARK: - IVars
    
    private lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton        = true
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = true
            $0.showOverlayView        = true
            $0.cancelButtonTitle = NSLocalizedString("qrcode.cancel_button", comment: "")
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    
    private var parentVC: UIViewController
    private var scannedQr: QRData?
    
    var delegate: QRReaderManagerDelegate?
    
    // MARK: - Init
    
    init(parentVC: UIViewController) {
        self.parentVC = parentVC
    }
    
    // MARK: - Public method
    
    func scan() {
        
        if QRCodeReader.isAvailable() {
            
            // Or by using the closure pattern
            readerVC.completionBlock = { [weak self] (result: QRCodeReaderResult?) in
                self?.decryptQrResult(result)
            }
            readerVC.delegate = self
            
            // Presents the readerVC as modal form sheet
            readerVC.modalPresentationStyle = .formSheet
            parentVC.present(readerVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private methods
    
    private func decryptQrResult(_ result: QRCodeReaderResult?) {
        
        // stop scan
        
        self.readerVC.stopScanning()
        
        guard let value = result?.value else {
            // no result
            self.delegate?.didFinishWithError()
            return
        }
        
        scannedQr = QRData(mediaId: value)
        endQrScan()
    }
    
    private func decryptQrValue(_ qrValue: String) {
        
        // Valid Qr
        // creazione qr
        endQrScan()
    }
    
    private func endQrScan() {
        
        self.parentVC.dismiss(animated: true) {
            guard let scannedQr = self.scannedQr else { return }
            self.delegate?.didFinish(with: scannedQr)
        }
    }
}

// MARK: - QRCodeReaderViewControllerDelegate

extension QRReaderManager: QRCodeReaderViewControllerDelegate {
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {}
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        self.parentVC.dismiss(animated: true)
    }
}
