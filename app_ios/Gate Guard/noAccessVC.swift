//
//  noAccessVC.swift
//  Gate Guard
//
//  Created by Ram on 3/30/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class noAccessVC: UIViewController {

    @IBOutlet weak var deviceName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.deviceName.text = "' \(UIDevice.current.name) '"
    }

}
