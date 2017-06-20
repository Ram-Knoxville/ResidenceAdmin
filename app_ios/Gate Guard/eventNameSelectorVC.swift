//
//  eventNameSelectorVC.swift
//  Gate Guard
//
//  Created by Ram on 6/19/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class eventNameSelectorVC: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTxt.keyboardAppearance = UIKeyboardAppearance.dark
        self.nameTxt.returnKeyType = UIReturnKeyType.done
    }

    @IBAction func backDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
