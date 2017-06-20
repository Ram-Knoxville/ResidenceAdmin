//
//  alarmEventsListVC.swift
//  Gate Guard
//
//  Created by Ram on 6/19/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class alarmEventsListVC: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
    }

}
