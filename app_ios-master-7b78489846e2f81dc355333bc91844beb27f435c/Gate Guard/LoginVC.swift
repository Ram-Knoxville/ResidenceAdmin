//
//  LoginVC.swift
//  Gate Guard
//
//  Created by Ram on 2/23/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire
import SwiftGifOrigin
import SwiftKeychainWrapper

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var logErrorLbl: UILabel!
    @IBOutlet weak var enterBtnStyle: UIButton!
    @IBOutlet weak var forgotPasswordTxt: UIButton!
    
    @IBOutlet weak var loader: UIImageView!
    
    
    var profiles = [String]()
    var profileId = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let username: String = KeychainWrapper.standard.string(forKey: "username"), let password: String = KeychainWrapper.standard.string(forKey: "password")
        {
            self.emailTxt.text = username
            self.passwordTxt.text = password
            self.loginAnimations()
        }
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()

//        let loadingGif = UIImage.gif(name: "loading")
        self.loader.isHidden = true
        self.loader.loadGif(name: "loading")
        self.loader.animationDuration = 0.002
        
        
        self.emailTxt.returnKeyType = UIReturnKeyType.next
        self.emailTxt.keyboardAppearance = UIKeyboardAppearance.dark
        self.emailTxt.delegate = self
        
        self.passwordTxt.returnKeyType = UIReturnKeyType.done
        self.passwordTxt.keyboardAppearance = UIKeyboardAppearance.dark
        self.passwordTxt.delegate = self
        
        self.enterBtnStyle.layer.cornerRadius = 5.0
        
        self.logErrorLbl.isHidden = true
    }
    
    func loginAnimations(){
        //Start Activity Indicator
        self.enterBtnStyle.isHidden = true
        self.emailTxt.isHidden = true
        self.passwordTxt.isHidden = true
        self.loader.isHidden = false
        performSegue(withIdentifier: "autoSegue", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTxt.resignFirstResponder()
        if textField == emailTxt { // Switch focus to other text field
            self.passwordTxt.becomeFirstResponder()
        }else if textField == passwordTxt {
            self.passwordTxt.endEditing(true)
        }
        return true
    }
    
    @IBAction func logginBtnPressed(_ sender: Any) {
        if emailTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            
            // Red placeholders
            emailTxt.attributedPlaceholder = NSAttributedString(string: "Correo", attributes: [NSForegroundColorAttributeName: UIColor.red])
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSForegroundColorAttributeName:UIColor.red])
            // Alert
            let alert = UIAlertController(title: "Alerta", message: "Porfavor llene los campos correspondientes a usuario y contraseña", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }else{
            
            //Start Activity Indicator
            self.enterBtnStyle.isHidden = true
            self.emailTxt.isHidden = true
            self.passwordTxt.isHidden = true
            
            self.loader.isHidden = false
            
            
            //Send request to server
            
            let username = emailTxt.text!.lowercased()
            let password = passwordTxt.text!
            
            let urlString = "http://api.gateguard.com.mx/api/Accounts/login"
            
            let parameters: Parameters = [
                "email": username,
                "password": password
            ]
            
            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                
                let result = response.result
                
                
                
                if let dict = result.value as? Dictionary<String, AnyObject>{
                    
                    print("Aqui empieza el diccionario \(dict)")
                    
                    if dict["status"] as? String != "OK" {
                        
                        // Stop Actvity Indicator
                        self.enterBtnStyle.isHidden = false
                        self.emailTxt.isHidden = false
                        self.passwordTxt.isHidden = false
                        self.loader.isHidden = true
                        
                        // Red placeholders
                        self.emailTxt.attributedPlaceholder = NSAttributedString(string: "Correo", attributes: [NSForegroundColorAttributeName: UIColor.red])
                        self.passwordTxt.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSForegroundColorAttributeName:UIColor.red])
                        
                        self.logErrorLbl.isHidden = false
                        
                        
                    }else if dict["status"] as? String == "OK"{

                        for i in dict["data"]!["profiles"] as! [[String : Any]]{
                            
                            self.profiles.append(i["name"]! as! String)
                        }
                        
                        for i in dict["data"]!["profiles"] as! [[String: Any]]{
                            self.profileId.append(i["uid"]! as! String)
                        }
                        
                        var userDataArray = [String]()
                        
                        var userEmail: String!
                        var userFirstName: String!
                        var userLastName: String!
                        var userPhoto: String!
                        
                        for i in dict["data"]!["userdata"] as! NSDictionary{
                            
                            userDataArray.append(i.value as! String)
                            
                            if i.key as! String == "email" {
                                userEmail = i.value as! String
                            }else if i.key as! String == "firstNames"{
                                userFirstName = i.value as! String
                            }else if i.key as! String == "lastNames"{
                                userLastName = i.value as! String
                            }else if i.key as! String == "photo"{
                                userPhoto = i.value as! String
                            }
                        }
                            print(userDataArray)
                        
                        var userSessionArray = [String]()
                        var token: String!
                        for i in dict["data"]!["session"] as! NSDictionary{
                            
                            userSessionArray.append("\(i.key): \(i.value)")
                            
                            if i.key as! String == "token" {
                                token = i.value as! String
                            }
                            
                        }
                        
                        print(token)
                        
                        let userToken: String! = token
                        let userUid = userSessionArray[1]
                        
                        print(userToken!)
                        
                        let firstName = userFirstName
                        let lastName = userLastName
                        
                        let fullName = firstName! + " " + lastName!
                        
                        //Save usefull information on memory
                        let defaults = UserDefaults.standard
                        defaults.set(self.profiles, forKey: "perfiles")
                        defaults.set(firstName, forKey: "UserFirstName")
                        defaults.set(fullName, forKey: "fullName")
                        defaults.set(userToken, forKey: "UserToken")
                        defaults.set(userUid, forKey: "userUid")
                        defaults.set(self.profileId, forKey: "profileId")
                        
                        // Save credentials on keychain
                        let usernameCredential: String! = self.emailTxt.text
                        let passwordCredential: String! = self.passwordTxt.text
                        
                        print(usernameCredential!)
                        print(passwordCredential!)
                        
                        KeychainWrapper.standard.set(usernameCredential!, forKey: "username")
                        KeychainWrapper.standard.set(passwordCredential!, forKey: "password")
                        KeychainWrapper.standard.set(userToken, forKey: "token")
                        KeychainWrapper.standard.set(userPhoto, forKey: "userPhoto")
                        print(KeychainWrapper.standard.string(forKey: "username")!)
                        print(KeychainWrapper.standard.string(forKey: "password")!)
                        print(KeychainWrapper.standard.string(forKey: "token")!)
                        // Stop Actvity Indicator
                        self.enterBtnStyle.isHidden = false
                        self.emailTxt.isHidden = false
                        self.passwordTxt.isHidden = false
                        self.loader.isHidden = true
                        
                        self.logErrorLbl.isHidden = true
                        //Perform Segue
                        self.performSegue(withIdentifier: "loginToPicker", sender: nil)
                    }
                }
            }
        }
    }
}
