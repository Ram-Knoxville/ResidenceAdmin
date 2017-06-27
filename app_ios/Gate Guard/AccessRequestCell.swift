//
//  AccessRequestCell.swift
//  Gate Guard
//
//  Created by Ram on 6/15/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire

class AccessRequestCell: UITableViewCell {
    
    
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var platesNumber: UILabel!
    @IBOutlet weak var tiempoEspera: UILabel!
    
    var acceso: AccessRequest!
    
    
    func configureCell(Acceso: AccessRequest){
        acceso = Acceso

        
        self.driverName.text = acceso.driver
        self.tiempoEspera.text = acceso.time

    }
    
    /*@IBAction func allowAccessBtnPressed(_ sender: Any) {
     
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/updateVisitorAccessMobile"
        
        let accountId: String! = UserDefaults.standard.string(forKey: "userUid")!
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        
        let parameters: Parameters = [
            "uid": acceso.uid,
            "Acceso": 1,
            "accountId": accountId,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON que buscas: \(JSON)")
            }
            
            
            
        }
    
    }
    
    @IBAction func denyAccessBtnPressed(_ sender: Any) {
     
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/updateVisitorAccessMobile"
        
        let accountId: String! = UserDefaults.standard.string(forKey: "userUid")!
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        
        let parameters: Parameters = [
            "uid": acceso.uid,
            "Acceso": 0,
            "accountId": accountId,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON que buscas: \(JSON)")
            }
            
            
        }

        
        
    }*/
    
}
