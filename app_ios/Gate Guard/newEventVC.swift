//
//  newEventVC.swift
//  Gate Guard
//
//  Created by Ram on 6/19/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class newEventVC: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.timePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveEvent(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
