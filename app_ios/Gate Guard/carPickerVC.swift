//
//  carPickerVC.swift
//  Gate Guard
//
//  Created by Ram on 6/19/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class carPickerVC: UIViewController {

    
    @IBOutlet weak var check2: UILabel!
    @IBOutlet weak var check3: UILabel!
    @IBOutlet weak var check4: UILabel!
    @IBOutlet weak var check5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.check2.isHidden = true
        self.check3.isHidden = true
        self.check4.isHidden = true
        self.check5.isHidden = true
    }
    
    @IBAction func second(_ sender: Any) {
        if self.check2.isHidden == true {
            self.check2.isHidden = false
        }else {
            self.check2.isHidden = true
        }
    }
    
    @IBAction func third(_ sender: Any) {
        if self.check3.isHidden == true {
            self.check3.isHidden = false
        }else {
            self.check3.isHidden = true
        }
    }
    
    @IBAction func fourth(_ sender: Any) {
        if self.check4.isHidden == true {
            self.check4.isHidden = false
        }else {
            self.check4.isHidden = true
        }
    }
    
    @IBAction func fifth(_ sender: Any) {
        if self.check5.isHidden == true {
            self.check5.isHidden = false
        }else {
            self.check5.isHidden = true
        }
    }
    

    @IBAction func backDismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
