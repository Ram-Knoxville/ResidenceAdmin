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
    
    var driver: String!
    
    var plateInfo: String!
    
    
    @IBOutlet weak var textoInfo: UITextView!
    @IBOutlet weak var seeInfoBtn: UIButton!
    @IBOutlet weak var approveBtn: UIButton!
    @IBOutlet weak var DenyBtn: UIButton!
    @IBOutlet weak var alertText: UITextView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        id = UserDefaults.standard.string(forKey: "idToAuth")!
        
        self.textoInfo.isHidden = true
        self.approveBtn.isHidden = true
        self.DenyBtn.isHidden = true
        self.activitySpinner.isHidden = true
        self.alertText.isHidden = false
        self.seeInfoBtn.isHidden = false
        
        
        
        
    }
    
    func getData(){
        
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/getVisitorMobile"

        let token: String! = UserDefaults.standard.string(forKey: "token")!
        
        let parameters: Parameters = [
            "accessUid": self.id,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            let result = response.result

            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                print("Aqui empieza el diccionario \(dict)")
                var info1: String!
                var info2: String!
                
                for i in dict["data"]!["access"] as! NSDictionary{
                    if i.key as! String == "driver" {
                        info1 = i.value as! String
                    }else if i.key as! String == "plate" {
                        info2 = i.value as! String
                    }
                }
                
                self.driver = info1
                self.plateInfo = info2
                
                self.textoInfo.text = "El Visitante " + self.driver + " solicita autorización de acceso al fraccionamiento en vehiculo con placa: " + self.plateInfo
                    
                self.textoInfo.isHidden = false
                self.approveBtn.isHidden = false
                self.DenyBtn.isHidden = false
                self.activitySpinner.stopAnimating()
                self.activitySpinner.isHidden = true
                self.seeInfoBtn.isHidden = true
                self.alertText.isHidden = true
                
            }
            
        }

        
    }
    
    
    @IBAction func seeInfo(_ sender: Any) {
        self.activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        self.getData()
    }
    

    @IBAction func allowAccessPressed(_ sender: Any) {
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/updateVisitorAccessMobile"
        
        let accountId: String! = UserDefaults.standard.string(forKey: "userUid")!
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        
        let parameters: Parameters = [
            "id": self.id,
            "Acceso": 1,
            "accountUid": accountId,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseString { response in
            
            print(response.result.value!)
            
            /*if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }*/
            
            
        }
        
        performSegue(withIdentifier: "goHome", sender: nil)
    }
    @IBAction func denyAccessPressed(_ sender: Any) {
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/updateVisitorAccessMobile"
        
        let accountId: String! = UserDefaults.standard.string(forKey: "userUid")!
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        
        let parameters: Parameters = [
            "id": self.id,
            "Acceso": 0,
            "accountUid": accountId,
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
