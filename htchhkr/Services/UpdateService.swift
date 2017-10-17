//
//  UpdateService.swift
//  htchhkr
//
//  Created by Andrew Greenough on 26/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class UpdateService {
    
    static let instance = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for user in userSnapshot {
                    if user.key == Auth.auth().currentUser?.uid {
                        DataService.instance.REF_USERS.child(user.key).updateChildValues(["coordinate" : [coordinate.latitude, coordinate.longitude]])
                    }
                }
            }
        })
    }
    
    func updateDriverLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for driver in driverSnapshot {
                    if driver.key == Auth.auth().currentUser?.uid {
                        if driver.childSnapshot(forPath: "isPickupModeEnabled").value as? Bool == true {
                            DataService.instance.REF_DRIVERS.child(driver.key).updateChildValues(["coordinate" : [coordinate.latitude, coordinate.longitude]])
                        }
                    }
                }
            }
        })
    }
    
    func observeTrips(handler: @escaping(_ coordinateDict: [String : Any]?) -> Void) {
        DataService.instance.REF_TRIPS.observe(.value, with: { (snapshot) in
            if let tripSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for trip in tripSnapshot {
                    if trip.hasChild("passengerKey") && trip.hasChild("tripIsAccepted") {
                        if let tripDict = trip.value as? [String : Any] {
                            handler(tripDict)
                        }
                    }
                }
            }
        })
    }
    
    func updateTripsWithCoordinatesUponRequest() {
        let currentUserId = Auth.auth().currentUser?.uid
        DataService.instance.REF_USERS.child(currentUserId!).observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChild("userIsDriver") {
                if let userDict = snapshot.value as? [String : Any] {
                    let pickupArray = userDict["coordinate"] as! NSArray
                    let destinationArray = userDict["tripCoordinate"] as! NSArray
                    
                    DataService.instance.REF_TRIPS.child(currentUserId!).updateChildValues(["pickupCoordinate" : [pickupArray.firstObject, pickupArray.lastObject], "destinationCoordinate" : [destinationArray.firstObject, destinationArray.lastObject], "passengerKey" : currentUserId!, "tripIsAccepted" : false])
                }
            }
        })
    }
}
