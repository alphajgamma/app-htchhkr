//
//  AlertService.swift
//  htchhkr
//
//  Created by Andrew Greenough on 26/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import UIKit

class AlertService {
    static let instance = AlertService()
    
    func displayAlert(fromViewController controller: UIViewController, withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
