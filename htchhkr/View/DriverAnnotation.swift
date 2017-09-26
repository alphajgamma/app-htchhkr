//
//  DriverAnnotation.swift
//  htchhkr
//
//  Created by Andrew Greenough on 26/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import Foundation
import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, withKey key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
    
    func update(annotationPosition annotation: DriverAnnotation, withCoordinate coordinate: CLLocationCoordinate2D) {
        var location = self.coordinate
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        UIView.animate(withDuration: 0.2) {
            self.coordinate = location
        }
    }
}
