//
//  AccessReportVC.swift
//  Gate Guard
//
//  Created by Ram on 4/20/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire

class AccessReportVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var accessRegistryTable: UITableView!
    
    let token: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")!
    let residenceUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")!//KeychainWrapper.standard.string(forKey: "ResidenceUid")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.accessRegistryTable.delegate = self
        self.accessRegistryTable.dataSource = self
        
        
        
    }
    
    func getData(token: String, residenceUid: String) {
        
        let urlString = "http://api.gateguard.com.mx/api/Access/getAccessToResidenceMobile"
        
        let parameters: Parameters = [
            "token": token,
            "residenceUid": residenceUid,
            "dateFrom": "2016/12/04",
            "dateTo": "2017/04/20",
            "plate": "",
            "name": ""
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON : \(JSON)")
            }
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = "Hola Mundo"
        
        
        return cell
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
