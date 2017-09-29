//
//  RoundMapView.swift
//  htchhkr
//
//  Created by Andrew Greenough on 29/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import UIKit
import MapKit

class RoundMapView: MKMapView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 10.0
    }

}
