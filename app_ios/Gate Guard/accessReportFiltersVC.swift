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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getListBtnPressed(_ sender: Any) {
        
        let token: String! = KeychainWrapper.standard.string(forKey: "token")
        let residenceUid: String! = KeychainWrapper.standard.string(forKey: "ResidenceUid")
        
        let urlString = "http://api.gateguard.com.mx/api/Access/getAccessToResidenceMobile"
        
        let parameters: Parameters = [
            "token": token,
            "residenceUid": residenceUid,
            "dateFrom": "",
            "dateTo": "",
            "plate": "",
            "name": "",
            "residentUid": residenceUid
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseString { response in
            
            if let JSON = response.result.value {
                print("JSON : \(JSON)")
            }
            
        }

    }

}
