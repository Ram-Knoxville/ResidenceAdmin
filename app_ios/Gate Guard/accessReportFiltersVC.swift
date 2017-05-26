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
    
    @IBOutlet weak var dateFromPicker: UIDatePicker!
    @IBOutlet weak var dateToPicker: UIDatePicker!
    @IBOutlet weak var plateTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getListBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
