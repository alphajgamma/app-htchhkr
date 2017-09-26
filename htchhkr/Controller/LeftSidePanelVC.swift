//
//  LeftSidePanelVC.swift
//  htchhkr
//
//  Created by Andrew Greenough on 25/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {
    
    let appDelegate = AppDelegate.getAppDelegate()
    let currentUserId = Auth.auth().currentUser?.uid
    
    // Outlets
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var UserAccountTypeLbl: UILabel!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var loginOutBtn: UIButton!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var pickupModeLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetView()
        observePassengersAndDrivers()
    }
    
    func resetView(){
        if Auth.auth().currentUser == nil {
            pickupModeSwitch.isOn = false
            pickupModeSwitch.isHidden = true
            pickupModeLbl.isHidden = true
            userEmailLbl.text = ""
            UserAccountTypeLbl.text = ""
            userImageView.isHidden = true
            loginOutBtn.setTitle("Sign Up / Login", for: .normal)
        } else {
            userEmailLbl.text = Auth.auth().currentUser?.email
            UserAccountTypeLbl.text = ""
            userImageView.isHidden = false
            loginOutBtn.setTitle("Logout", for: .normal)
        }
    }
    
    func observePassengersAndDrivers() {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.UserAccountTypeLbl.text = "PASSENGER"
                    }
                }
            }
        })
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.UserAccountTypeLbl.text = "DRIVER"
                        self.pickupModeSwitch.isHidden = false
                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                        self.pickupModeLbl.isHidden = false
                        if switchStatus == true {
                            self.pickupModeLbl.text = "PICKUP MODE ENABLED"
                        } else {
                            self.pickupModeLbl.text = "PICKUP MODE DISABLED"
                        }
                        
                    }
                }
            }
        })
    }

    @IBAction func switchWasToggled(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickupModeLbl.text = "PICKUP MODE ENABLED"
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled" : true])
        } else {
            pickupModeLbl.text = "PICKUP MODE DISABLED"
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled" : false])
        }
    }
    
    @IBAction func signUpLoginBtnWasPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            present(loginVC!, animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
                resetView()
            } catch (let error) {
                AlertService.instance.displayAlert(fromViewController: self, withTitle: "Sign Out Error", andMessage: error.localizedDescription)
            }
        }
    }
}
