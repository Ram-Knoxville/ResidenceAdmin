//
//  weekDaysVC.swift
//  Gate Guard
//
//  Created by Ram on 6/19/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class weekDaysVC: UIViewController {

    @IBOutlet weak var check1: UILabel!
    @IBOutlet weak var check2: UILabel!
    @IBOutlet weak var check3: UILabel!
    @IBOutlet weak var check4: UILabel!
    @IBOutlet weak var check5: UILabel!
    @IBOutlet weak var check6: UILabel!
    @IBOutlet weak var check7: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.check1.isHidden = true
        self.check2.isHidden = true
        self.check3.isHidden = true
        self.check4.isHidden = true
        self.check5.isHidden = true
        self.check6.isHidden = true
        self.check7.isHidden = true
    }
    
    @IBAction func sundayPressed(_ sender: Any){
        
        if check1.isHidden == true{
            check1.isHidden = false
        }else{
            check1.isHidden = true
        }
        
    }
    
    @IBAction func mondayPressed(_ sender: Any){
        if check2.isHidden == true{
            check2.isHidden = false
        }else{
            check2.isHidden = true
        }
    }
    
    @IBAction func tuesdayPressed(_ sender: Any){
        if check3.isHidden == true{
            check3.isHidden = false
        }else{
            check3.isHidden = true
        }
    }

    @IBAction func wednesdayPressed(_ sender: Any){
        if check4.isHidden == true{
            check4.isHidden = false
        }else{
            check4.isHidden = true
        }
    }
    
    @IBAction func thursdayPressed(_ sender: Any){
        if check5.isHidden == true{
            check5.isHidden = false
        }else{
            check5.isHidden = true
        }
    }
    
    @IBAction func fridayPressed(_ sender: Any){
        if check6.isHidden == true{
            check6.isHidden = false
        }else{
            check6.isHidden = true
        }
    }
    
    @IBAction func saturdayPressed(_ sender: Any){
        if check7.isHidden == true{
            check7.isHidden = false
        }else{
            check7.isHidden = true
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
}
