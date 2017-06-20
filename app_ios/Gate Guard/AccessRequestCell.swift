//
//  AccessRequestCell.swift
//  Gate Guard
//
//  Created by Ram on 6/15/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire

class AccessRequestCell: UICollectionViewCell {
    
    @IBOutlet weak var cameraViewImage: UIImageView!
    @IBOutlet weak var plateImage: UIImageView!
    @IBOutlet weak var allowBtn: UIButton!
    @IBOutlet weak var deny: UIButton!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var residenceToVisit: UILabel!
    @IBOutlet weak var platesNumber: UILabel!
    @IBOutlet weak var tiempoEspera: UILabel!
    
    var acceso: AccessRequest!
    
    
    func configureCell(Acceso: AccessRequest){
        acceso = Acceso
        
        self.allowBtn.layer.borderWidth = 1
        self.allowBtn.layer.borderColor = UIColor.white.cgColor
        
        self.deny.layer.borderWidth = 1
        self.deny.layer.borderColor = UIColor.white.cgColor
        
        self.driverName.text = acceso.driver
        self.residenceToVisit.text = acceso.address
        self.tiempoEspera.text = acceso.time
        
        
        //let placa: String! = "http://api.gateguard.com.mx/uploads/vehicles/cam_1/\(acceso.plateImg)"
        
        /*let url = NSURL(string: placa)!
        if let data = NSData(contentsOf: url as URL){
            
            self.plateImage.image = UIImage(data: data as Data)
            
        }*/
        
    }
    
    @IBAction func allowAccessBtnPressed(_ sender: Any) {
     
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/updateVisitorAccessMobile"
        
        let accountId: String! = UserDefaults.standard.string(forKey: "userUid")!
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        
        let parameters: Parameters = [
            "id": acceso.uid,
            "Acceso": 1,
            "accountId": accountId,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
        }

        
        
        
        
    }
    
    @IBAction func denyAccessBtnPressed(_ sender: Any) {
     
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/updateVisitorAccessMobile"
        
        let accountId: String! = UserDefaults.standard.string(forKey: "userUid")!
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        
        let parameters: Parameters = [
            "id": acceso.uid,
            "Acceso": 0,
            "accountId": accountId,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            
        }

        
        
    }
    
}
