//
//  accessReportFiltersVC.swift
//  Gate Guard
//
//  Created by Ram on 4/20/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire


class accessReportFiltersVC: UIViewController {
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var dateFromPicker: UIDatePicker!
    @IBOutlet weak var dateToPicker: UIDatePicker!
    @IBOutlet weak var plateTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var avoidingView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        KeyboardAvoiding.avoidingView = self.avoidingView
        
    }
    
    @IBAction func getListBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "viewAccessLog", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.nameTxtField {
            KeyboardAvoiding.padding = 20
            KeyboardAvoiding.avoidingView = textField
            KeyboardAvoiding.padding = 0
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTxtField {
            
            textField.resignFirstResponder()
        }
        return true
    }
}
