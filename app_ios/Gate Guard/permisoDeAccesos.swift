//
//  permisoDeAccesos.swift
//  Gate Guard
//
//  Created by Ram on 4/3/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire

class permisoDeAccesos: UIViewController {
    
    var id: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        id = KeychainWrapper.standard.string(forKey: "idToAuth")!
        id = UserDefaults.standard.string(forKey: "idToAuth")!
        
    }
    
    

    @IBAction func allowAccessPressed(_ sender: Any) {
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/updateVisitorAccessMobile"
        
        let accountId: String! = UserDefaults.standard.string(forKey: "userId")!
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        
        let parameters: Parameters = [
            "id": self.id,
            "Acceso": 1,
            "accountId": accountId,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            
        }
        
        performSegue(withIdentifier: "goHome", sender: nil)
    }
    @IBAction func denyAccessPressed(_ sender: Any) {
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/updateVisitorAccessMobile"
        
        let accountId: String! = UserDefaults.standard.string(forKey: "userId")!
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        
        let parameters: Parameters = [
            "id": self.id,
            "Acceso": 0,
            "accountId": accountId,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            
        }
        
        performSegue(withIdentifier: "goHome", sender: nil)
    }
}
