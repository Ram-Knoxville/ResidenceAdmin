//
//  ARVC.swift
//  Gate Guard
//
//  Created by Ram on 3/25/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import HDAugmentedReality

class ARVC: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
    }

}
