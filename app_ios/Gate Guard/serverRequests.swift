//
//  serverRequests.swift
//  Gate Guard
//
//  Created by Ram on 3/24/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ServerRequests {
    
    func getUsers(profileId: String, suburId: String, residenceUid: String) {
        
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/Users/getUsers"
        
        let parameters: Parameters = [
            "profileId": profileId,
            "suburID": suburId,
            "residenceUid": residenceUid
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                print("Aqui empieza el diccionario \(dict)")
                
                if dict["status"] as? String != "OK" {
               
                }else if dict["status"] as? String == "OK"{
                    
                }
            }
        }
    }
}
