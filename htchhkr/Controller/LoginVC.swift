//
//  LoginVC.swift
//  htchhkr
//
//  Created by Andrew Greenough on 25/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var emailTxtField: RoundedCornerTextField!
    @IBOutlet weak var passwordTxtField: RoundedCornerTextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var authBtn: RoundedShadowButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        view.bindToKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func authBtnWasPressed(_ sender: Any) {
        if emailTxtField.text != nil && passwordTxtField.text != nil {
            authBtn.animateButton(shouldLoad: true, withMessage: nil)
            view.endEditing(true)
            if let email = emailTxtField.text, let password = passwordTxtField.text {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if let error = error {
                        if let errorCode = AuthErrorCode(rawValue: error._code) {
                            switch errorCode {
                            case .userNotFound:
                                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                                    if let error = error {
                                        self.displayAlert(withTitle: "Authentication Error", andMessage: error.localizedDescription)
                                    } else {
                                        if let user = user {
                                            if self.segmentedControl.selectedSegmentIndex == 0 {
                                                let userData = ["provider" : user.providerID] as [String : Any]
                                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                                            } else {
                                                let userData = ["provider" : user.providerID, "userIsDriver" : true, "isPickupModeEnabled" : false, "driverIsOnTrip" : false] as [String : Any]
                                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                                            }
                                        }
                                        print("Successfully created a new email auth user in Firebase")
                                        self.dismiss(animated: true, completion: nil)
                                    }
                                })
                            default:
                                self.displayAlert(withTitle: "Authentication Error", andMessage: error.localizedDescription)
                            }
                        }
                    } else {
                        if let user = user {
                            if self.segmentedControl.selectedSegmentIndex == 0 {
                                let userData = ["provider" : user.providerID] as [String : Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = ["provider" : user.providerID, "userIsDriver" : true, "isPickupModeEnabled" : false, "driverIsOnTrip" : false] as [String : Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("Email user authenticated successfully in Firebase")
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func displayAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
