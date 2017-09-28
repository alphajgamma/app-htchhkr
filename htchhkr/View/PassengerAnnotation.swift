//
//  PassengerAnnotation.swift
//  htchhkr
//
//  Created by Andrew Greenough on 28/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, withKey key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
