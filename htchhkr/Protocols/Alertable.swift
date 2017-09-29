//
//  Alertable.swift
//  htchhkr
//
//  Created by Andrew Greenough on 29/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import UIKit

protocol Alertable {}
extension Alertable where Self: UIViewController {
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
