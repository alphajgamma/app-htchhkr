//
//  CenterVCDelegate.swift
//  htchhkr
//
//  Created by Andrew Greenough on 25/09/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
