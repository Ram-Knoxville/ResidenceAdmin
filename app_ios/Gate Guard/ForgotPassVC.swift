//
//  ForgotPassVC.swift
//  Gate Guard
//
//  Created by Ram on 2/23/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPassVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func resetPasswordBtn(_ sender: Any) {
        
        if emailTxt.text!.isEmpty {
            // Red placeholders
            emailTxt.attributedPlaceholder = NSAttributedString(string: "Correo", attributes: [NSForegroundColorAttributeName: UIColor.red])
            // Alert
            let alert = UIAlertController(title: "Alerta", message: "Para resetear contraseña es necesario nos proporcione su correo de usuario", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let email = emailTxt.text!.lowercased()
            
            let urlString = "http://api.gateguard.com.mx/api/Accounts/send_email_password_post"
            
            let parameters: Parameters = [
                "email": email
            ]
            
            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                
                let result = response.result
                
                if let dict = result.value as? Dictionary<String, AnyObject>{
                    
                    print("Aqui empieza el diccionario \(dict)")
                    if dict["status"] as? String != "OK" {
                        
                        // Alert
                        let alert = UIAlertController(title: "Alerta", message: "Si el correo proporcionado esta registrado, se enviara un correo para restablecer la contraseña", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else if dict["status"] as? String == "OK"{
                        // Alert
                        let alert = UIAlertController(title: "Alerta", message: "Si el correo proporcionado esta registrado, se enviara un correo para restablecer la contraseña", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }

        }
        
        
    }
    

}
