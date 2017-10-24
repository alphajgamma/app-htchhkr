//
//  LeftSidePanelVC.swift
//  htchhkr
//
//  Created by Andrew Greenough on 25/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController, Alertable {
    
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
            userEmailLbl.text = ""
            UserAccountTypeLbl.text = ""
            userImageView.isHidden = true
            loginOutBtn.setTitle(MSG_SIGN_UP_SIGN_IN, for: .normal)
        } else {
            userEmailLbl.text = Auth.auth().currentUser?.email
            UserAccountTypeLbl.text = ""
            userImageView.isHidden = false
            loginOutBtn.setTitle(MSG_SIGN_OUT, for: .normal)
        }
    }
    
    func observePassengersAndDrivers() {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.UserAccountTypeLbl.text = ACCOUNT_TYPE_PASSENGER
                        self.pickupModeSwitch.isHidden = true
                        self.pickupModeLbl.isHidden = true
                    }
                }
            }
        })
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.UserAccountTypeLbl.text = ACCOUNT_TYPE_DRIVER
                        self.pickupModeSwitch.isHidden = false
                        let switchStatus = snap.childSnapshot(forPath: ACCOUNT_PICKUP_MODE_ENABLED).value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                        self.pickupModeLbl.isHidden = false
                        if switchStatus == true {
                            self.pickupModeLbl.text = MSG_PICKUP_MODE_ENABLED
                        } else {
                            self.pickupModeLbl.text = MSG_PICKUP_MODE_DISABLED
                        }
                        
                    }
                }
            }
        })
    }

    @IBAction func switchWasToggled(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickupModeLbl.text = MSG_PICKUP_MODE_ENABLED
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues([ACCOUNT_PICKUP_MODE_ENABLED : true])
        } else {
            pickupModeLbl.text = MSG_PICKUP_MODE_DISABLED
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues([ACCOUNT_PICKUP_MODE_ENABLED : false])
        }
    }
    
    @IBAction func signUpLoginBtnWasPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: STORYBOARD_MAIN, bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: VC_LOGIN) as? LoginVC
            present(loginVC!, animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
                resetView()
            } catch (let error) {
                showAlert(withTitle: ERROR_MSG_TITLE_SIGN_OUT, andMessage: error.localizedDescription)
            }
        }
    }
}
