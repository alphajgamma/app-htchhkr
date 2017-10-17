//
//  DataService.swift
//  htchhkr
//
//  Created by Andrew Greenough on 25/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private(set) var REF_BASE = DB_BASE
    private(set) var REF_USERS = DB_BASE.child("users")
    private(set) var REF_DRIVERS = DB_BASE.child("drivers")
    private(set) var REF_TRIPS = DB_BASE.child("trips")
    
    func createFirebaseDBUser(uid: String, userData: [String : Any], isDriver: Bool) {
        if isDriver {
            REF_DRIVERS.child(uid).updateChildValues(userData)
        } else {
            REF_USERS.child(uid).updateChildValues(userData)
        }
    }
    
    func driverIsAvailable(key: String, handler: @escaping(_ status: Bool?) -> Void) {
        DataService.instance.REF_DRIVERS.child(key).observeSingleEvent(of: .value, with: { (driver) in
            if driver.childSnapshot(forPath: "isPickupModeEnabled").value as? Bool == true {
                if driver.childSnapshot(forPath: "driverIsOnTrip").value as? Bool == true {
                    handler(false)
                } else {
                    handler(true)
                }
            }
        })
    }
    
    func driverIsOnTrip(driverKey: String, handler: @escaping(_ status: Bool?, _ driverKey: String?, _ tripKey: String?) -> Void) {
        DataService.instance.REF_DRIVERS.child(driverKey).child("driverIsOnTrip").observe(.value, with: { (driverTripStatusSnapshot) in
            if let driverTripStatusSnapshot = driverTripStatusSnapshot.value as? Bool {
                if driverTripStatusSnapshot == true {
                    DataService.instance.REF_TRIPS.observeSingleEvent(of: .value, with: { (tripSnapshot) in
                        if let tripSnapshot = tripSnapshot.children.allObjects as? [DataSnapshot] {
                            for trip in tripSnapshot {
                                if trip.childSnapshot(forPath: "driverKey").value as? String == driverKey {
                                    handler(true, driverKey, trip.key)
                                } else {
                                    return
                                }
                            }
                        }
                    })
                } else {
                    handler(false, nil, nil)
                }
            }
        })
    }
    
    func passengerIsOnTrip(passengerKey: String, handler: @escaping(_ status: Bool?, _ driverKey: String?, _ tripKey: String?) -> Void) {
        DataService.instance.REF_TRIPS.child(passengerKey).observeSingleEvent(of: .value, with: { (tripSnapshot) in
            if tripSnapshot.exists() {
                if tripSnapshot.childSnapshot(forPath: "tripIsAccepted").value as? Bool == true {
                    let driverKey = tripSnapshot.childSnapshot(forPath: "driverKey").value as? String
                    handler(true, driverKey, passengerKey)
                } else {
                    handler(false, nil, nil)
                }
            } else {
                handler(false, nil, nil)
            }
        })
    }
    
    func userIsDriver(userKey: String, handler: @escaping(_ status: Bool) -> Void) {
        DataService.instance.REF_DRIVERS.child(userKey).observeSingleEvent(of: .value, with: { (driverSnapshot) in
            if driverSnapshot.exists() {
                handler(true)
            } else {
                handler(false)
            }
        })
    }
}
