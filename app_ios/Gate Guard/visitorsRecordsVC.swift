//
//  visitorsRecordsVC.swift
//  Gate Guard
//
//  Created by Ram on 5/25/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire

class visitorsRecordsVC: UIViewController {

    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.getData()
    }
    
    
    func getData(){
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        let residenceUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")
        
        let urlString = "http://api.gateguard.com.mx/api/Access/getAccessToResidenceMobile"
        
        let parameters: Parameters = [
            "residenceUid": residenceUid,
            "token": token,
            "dateFrom": "",
            "dateTo": "",
            "plate": "",
            "name": "",
            "residentUid": ""
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
        }
        
    }

}
