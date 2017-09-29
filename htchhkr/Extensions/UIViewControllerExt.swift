//
//  UIViewControllerExt.swift
//  htchhkr
//
//  Created by Andrew Greenough on 29/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func shouldPresentLoadingView(_ status: Bool) {
        var fadeView: UIView?
        
        if status == true {
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            fadeView?.backgroundColor = UIColor.black
            fadeView?.alpha = 0.0
            fadeView?.tag = 99
            
            let spinner = UIActivityIndicatorView()
            spinner.color = UIColor.white
            spinner.activityIndicatorViewStyle = .whiteLarge
            spinner.center = view.center
            
            view.addSubview(fadeView!)
            fadeView?.addSubview(spinner)
            
            spinner.startAnimating()
            
            fadeView?.fadeTo(alphaValue: 0.7, withDuration: 0.2)
        } else {
            for subView in view.subviews {
                if subView.tag == 99 {
                    UIView.animate(withDuration: 0.2, animations: {
                        subView.alpha = 0.0
                    }, completion: { (finished) in
                        subView.removeFromSuperview()
                    })
                }
            }
        }
    }
    
    func displayAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
