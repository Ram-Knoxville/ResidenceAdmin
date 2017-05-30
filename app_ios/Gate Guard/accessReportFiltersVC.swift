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
    
    var fromDate: Date!
    var toDate: Date!
    var plate: String!
    var name: String!
    
    var dataArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        KeyboardAvoiding.avoidingView = self.avoidingView
        
    }
    
    @IBAction func getListBtnPressed(_ sender: Any) {
        
        fromDate = self.dateFromPicker.date
        toDate = self.dateToPicker.date
        plate = self.plateTxtField.text
        name = self.nameTxtField.text
        
        dataArray = [fromDate, toDate, plate, name] as [Any]
        
        performSegue(withIdentifier: "viewAccessLog", sender: dataArray)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewAccessLog" {
            if let accessReportVC = segue.destination as? AccessReportVC {
                accessReportVC.feedMeArray = self.dataArray
            }
        }
        
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
