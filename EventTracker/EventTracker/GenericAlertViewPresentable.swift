//
//  GenericAlertViewProtocol.swift
//  AzamMedia
//
//   Created by Farooque on 21/02/17.
//  Copyright © 2016 NDTV World Wide. All rights reserved.
//

import UIKit

protocol GenericAlertViewPresentable { }

extension GenericAlertViewPresentable where Self: UIViewController {
    
    func displaySingleButtonAlertView(
        title: String,
        message: String = "",
        buttonLabel: String,
        style:  UIAlertActionStyle = .cancel,
        handler: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil
        ){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonLabel, style: style, handler: handler))
        DispatchQueue.main.async(execute: {
            self.present(alertController, animated: true, completion: completion)
        })
        
        
    }
    
    func displayDoubleButtonAlertView(
        title: String,
        message: String = "",
        firstButtonLabel: String,
        secondButtonLabel: String,
        firstStyle:  UIAlertActionStyle = .destructive,
        secondStyle:  UIAlertActionStyle = .default,
        firstHandler: ((UIAlertAction) -> Void)? = nil,
        secondHandler: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil
        ){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: firstButtonLabel, style: firstStyle, handler: firstHandler))
        alertController.addAction(UIAlertAction(title: secondButtonLabel, style: secondStyle, handler: secondHandler))
        DispatchQueue.main.async(execute: {
            self.present(alertController, animated: true, completion: completion)
        })
    }
}
