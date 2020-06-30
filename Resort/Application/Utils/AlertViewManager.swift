//
//  AlertViewManager.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 28/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation
import UIKit

class AlertViewManager {
    
    private let vc: UIViewController
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    // MARK: - Basic
    
    func show(title: String = Bundle.main.displayName,
                     message: String,
                     onDismiss: (() -> Void)?) {
                
        let actionSheetController = UIAlertController(title: title.capitalized, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: "").uppercased(), style: .default) { action -> Void in
            onDismiss?()
        }
        actionSheetController.addAction(okAction)
        vc.present(actionSheetController, animated: true, completion: nil)
    }
    
    func showWarning(message: String, onDismiss: (() -> Void)? = nil) {
        show(title: NSLocalizedString("warning", comment: "").capitalized, message: message, onDismiss: onDismiss)
    }
    
    func showGenericError(fromVC: UIViewController?, onDismiss: (() -> Void)? = nil) {
        self.show(title: Bundle.main.displayName,
                  message: NSLocalizedString("Si è verificato un errore, riprovare più tardi.", comment: ""),
                  onDismiss: onDismiss)
    }
    
    // MARK: - Yes/No
    
    func showYesNo(title: String? = nil,
                          message: String,
                          textYes: String = NSLocalizedString("si", comment: ""),
                          textNo: String = NSLocalizedString("no", comment: ""),
                          onYes: @escaping () -> Void,
                          onNo: (() -> Void)? = nil) {
                
        let actionSheetController = UIAlertController(title: title ?? Bundle.main.displayName, message: message, preferredStyle: .alert)
        
        // cancel action
        let cancelAction = UIAlertAction(title: textNo.capitalized, style: .cancel) { action -> Void in
            onNo?()
        }
        
        // yes action
        let yesAction = UIAlertAction(title: textYes.capitalized, style: .default) { action -> Void in
            onYes()
        }
        
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(yesAction)
        
        vc.present(actionSheetController, animated: true, completion: nil)
    }
    
    // MARK: - Popup
    
    func showPopUpView(withMessage message: String,
                              timeLenght: Double,
                              onDismiss: @escaping () -> Void) {
                
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.view.tintColor = .black
        vc.present(alert, animated: true, completion: {})
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeLenght, execute: {
            self.vc.dismiss(animated: true, completion: {onDismiss()})
        })
    }
    
    // MARK: - UITextFields
    
    func showDoubleTextField(title: String,
                                    message: String,
                                    firstPlaceholder: String,
                                    secondPlaceholder: String,
                                    cancelButtonText: String,
                                    okButtonText: String,
                                    view: UIViewController,
                                    onOkTap: @escaping (_ firstInputText: String, _ secondInputText: String) -> Void,
                                    onCancel: (() -> Void)?) {
        
        var firstInputTextField: UITextField?
        var secondInputTextField: UITextField?
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButtonText, style: .cancel, handler:  { (action) -> Void in
            onCancel?()
        }))
        alert.addAction(UIAlertAction(title: okButtonText, style: .default, handler: { (action) -> Void in
            
            guard let firstInputText = firstInputTextField?.text, let secondInputText = secondInputTextField?.text else { return }
            onOkTap(firstInputText, secondInputText)
        }))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            firstInputTextField = textField
            textField.placeholder = firstPlaceholder
        })
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            secondInputTextField = textField
            textField.placeholder = secondPlaceholder
        })
        
        /* change cursor color to get it displayed */
        for textField in alert.textFields! {
            textField.tintColor = .black
        }
        
        view.present(alert, animated: true, completion: nil)
    }
    
    func showTextField(title: String,
                              message: String,
                              view: UIViewController,
                              keyboardType: UIKeyboardType = .default,
                              onOkTap: @escaping (_ inputText: String) -> Void,
                              onCancel: (() -> Void)?) {
        
        var inputTextField: UITextField?
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "").capitalized,
                                      style: .cancel, handler:  { (action) -> Void in
                                        onCancel?()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("confirm", comment: "").capitalized,
                                      style: .default, handler: { (action) -> Void in
                                        
                                        guard let inputText = inputTextField?.text else { return }
                                        onOkTap(inputText)
                                        
        }))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            inputTextField = textField
        })
        
        /* change cursor color to get it displayed */
        for textField in alert.textFields! {
            textField.tintColor = .black
            textField.keyboardType = keyboardType
        }
        
        view.present(alert, animated: true, completion: nil)
    }
}
