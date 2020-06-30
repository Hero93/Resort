//
//  GetInTouchVC.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class GetInTouchVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var customHeaderView: CustomHeader! {
        didSet {
            customHeaderView.title = NSLocalizedString("get_in_touch.header.title", comment: "")
            customHeaderView.subtitle = NSLocalizedString("get_in_touch.header.subtitle", comment: "")
        }
    }
    
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private var phoneNumbersTextView: UITextView! {
        didSet {
            phoneNumbersTextView.isEditable = false
        }
    }
    @IBOutlet private weak var vatNumberLabel: UILabel!
    @IBOutlet private var emailTextView: UITextView! {
        didSet {
            emailTextView.isEditable = false
        }
    }
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    // MARK: - IVars
    
    var controller: GetInTouchController?

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        initBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        controller?.start()
    }
    
    // MARK: - Private methods

    func initBinding() {
                
        controller?.viewModel.addObserver(fireNow: false) { [weak self] (rowViewModels) in
            self?.fillViewWithData()
        }

        controller?.viewModel.value?.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.activityIndicatorView.startAnimating()
            } else {
                self?.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    private func fillViewWithData() {
        addressLabel.text = controller?.viewModel.value?.address
        phoneNumbersTextView.text = controller?.viewModel.value?.phoneNumbers
        underline(textView: phoneNumbersTextView)
        emailTextView.text = controller?.viewModel.value?.email
        underline(textView: emailTextView)
        vatNumberLabel.text = controller?.viewModel.value?.vatNumber
        

    }
    
    private func underline(textView: UITextView) {
        
        let myAttribute = [NSAttributedString.Key.font: UIFont.getCustomFont(.montserratRegular, size: 16.0),
                           NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let attributedString = NSMutableAttributedString(string: textView.text ?? "", attributes: myAttribute)
            textView.linkTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue): NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key: Any]?
            textView.attributedText = attributedString
    }
}
