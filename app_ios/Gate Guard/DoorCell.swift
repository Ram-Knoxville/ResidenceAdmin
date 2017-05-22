//
//  DoorCell.swift
//  Gate Guard
//
//  Created by Ram on 5/22/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire

class DoorCell: UICollectionViewCell {
    
    @IBOutlet weak var doorName: UILabel!
    
    
    
    var doors: Doors!
    
    
    func configureCell(door: Doors){
        self.doors = door
        
        self.doorName.text = doors.name
    }
    
    @IBAction func openGate(_ sender: Any) {
        let token: String! = UserDefaults.standard.string(forKey: "token")
        
        let urlString = "http://api.gateguard.com.mx/api/doors/openDoorOverride"
        
        let parameters: Parameters = [
            "doorUid": doors.uid,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
    }
    
}
