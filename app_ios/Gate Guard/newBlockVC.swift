//
//  newBlockVC.swift
//  Gate Guard
//
//  Created by Ram on 3/7/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class newBlockVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    @IBAction func backBtnPressed(_ sender: Any) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }


}
