//
//  OpenGateVC.swift
//  Gate Guard
//
//  Created by Ram on 4/25/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class OpenGateVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func openGate(_ sender: Any) {
        performSegue(withIdentifier: "goHomeFromGateOpen", sender: nil)
    }

}
