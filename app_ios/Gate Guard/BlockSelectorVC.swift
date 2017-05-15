//
//  BlockSelectorVC.swift
//  Gate Guard
//
//  Created by Ram on 2/23/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire
import SwiftGifOrigin
import SwiftKeychainWrapper

class BlockSelectorVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var BlocksList: UIPickerView!
    @IBOutlet weak var activityIndicator: UIImageView!
    
    @IBOutlet weak var usernameLbl: UILabel!
    
    @IBOutlet weak var enterBtn: UIButton!
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    var pickerData = [String]()
    var selectedProfile: String!
    var UserToken: String! = " "
    var profileId = [NSString]()
    var profileIdSelected: String!
    let defaults = UserDefaults.standard
    
    // variables for push notification registration
    
    var deviceToken: String!
    var userUid: String!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.string(forKey: "userPhoto") != nil {
            let picture: String! = UserDefaults.standard.string(forKey: "userPhoto")!
            
            let url = NSURL(string: "http://api.gateguard.com.mx/uploads/accounts/\(picture!)")!
            if let data = NSData(contentsOf: url as URL) {
                self.userPhoto.image = UIImage(data: data as Data)
            }
        }else {
            self.userPhoto.image = UIImage(named: "avatar.png")
        }
        
        
        if UserDefaults.standard.string(forKey: "userToken") != nil{
            self.UserToken = UserDefaults.standard.string(forKey: "userToken")!
        }
        
        if UserDefaults.standard.string(forKey: "profile") != nil {
            self.selectedProfile = UserDefaults.standard.string(forKey: "profile")!
            self.enterBtnPressed(self)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BlocksList.dataSource = self
        BlocksList.delegate = self
        
        self.activityIndicator.isHidden = true
        self.activityIndicator.loadGif(name: "loading")
        
        let row = BlocksList.selectedRow(inComponent: 0)
        
        //read from internal memory
        
        UserToken = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")!
        
        if let testArray : AnyObject? = UserDefaults.standard.object(forKey: "perfiles") as AnyObject?? {
            let readArray : [NSString] = testArray! as! [NSString]
            for i in readArray {
                pickerData.append(i as String)
            }
            
        }
        
        if let profileIdRead : AnyObject? = UserDefaults.standard.object(forKey: "profileId") as AnyObject??{
            let readArray : [NSString] = profileIdRead! as! [NSString]
            for i in readArray {
                profileId.append(i as NSString)
            }
        }
        
        profileIdSelected = profileId[row] as String
        selectedProfile = pickerData[row] as String
        
        if let userFirstName : String = UserDefaults.standard.object(forKey: "UserFirstName") as! String?{
            usernameLbl.text = userFirstName
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let valueSelected = pickerData[row] as String!
        
        profileIdSelected = String(describing: profileId[row])
        
        print("Este es el profileId que seleccionas \(profileIdSelected)")
        
        selectedProfile = valueSelected
        //Save usefull information on memory
        
        defaults.set(selectedProfile, forKey: "selectedProfile")
        defaults.set(self.selectedProfile, forKey: "profileSelected")
        defaults.set(profileIdSelected, forKey: "profileIdSelected")
        
//        KeychainWrapper.standard.set(selectedProfile, forKey: "selectedProfile")
        //Save usefull information on memory
        
    }

    @IBAction func enterBtnPressed(_ sender: Any) {
        
        
        if selectedProfile == "Selecciona" {
            
            let alert = UIAlertController(title: "Alerta", message: "Debe seleccionar un perfil para continuar", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default))
            self.present(alert, animated: true, completion: nil)
        
        }else{
            
            //Start Activity Indicator
            self.activityIndicator.isHidden = false
            self.BlocksList.isHidden = true
            self.enterBtn.isHidden = true
            
            
            
            //Send request to server
            
            let profile: String! = profileIdSelected
            let userToken: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")
            print(profile)
            print(userToken)
            let urlString = "http://api.gateguard.com.mx/api/Accounts/login2"
            
            let parameters: Parameters = [
                "profile": profile!,
                "token": userToken
            ]
            
            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                
                let result = response.result
                
                if let dict = result.value as? Dictionary<String, AnyObject>{
                    
                    print("Aqui empieza el diccionario principal\(dict)")
                    
                    if dict["status"] as? String != "OK"{
                    
                        // Stop Actvity Indicator
                        self.activityIndicator.isHidden = true
                        self.BlocksList.isHidden = false
                        self.enterBtn.isHidden = false
                        
                    }else if dict["status"] as? String  == "OK"{
                        
                        //Save Credentials on keychain Wrapper
                        self.defaults.set(profile!, forKey: "profile")
//                        KeychainWrapper.standard.set(profile!, forKey: "profile")
                        
                        let userToken: String! = self.UserToken
                        
                        
                        let urlString = "http://api.gateguard.com.mx/api/Accounts/session"
                        
                        let parameters: Parameters = [
                            "token": userToken
                        ]
                        
                        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                            
                            if let JSON = response.result.value {
                                print("Esta es la información de session que necesitas \(JSON)")
                            }
                            
                            let result = response.result
                            
                            if let dict2 = result.value as? Dictionary<String, AnyObject> {
                                
                                print("Diccionario Final bro ! \(dict2)")
                                
                                if dict2["status"] as? String != "OK"{
                                    
                                }else if dict2["status"] as? String  == "OK"{
                                    
                                    var profileDict = [Any]()
                                    var profileLogo: String!
                                    var profileProfileId: String!
                                    var profileProfileUid: String!
                                    var profileResidenceUid: String!
//                                    var profileResidenceId: String!
                                    var profileSuburbName: String!
                                    var profileSuburbUid: String!
                                    var roleId: String!
                                    var roleUid: String!
                                    
                                    for i in dict2["data"]!["role"] as! NSDictionary{
                                        if i.key as! String == "roleId" {
                                            roleId = i.value as! String
                                        }else if i.key as! String == "roleUid" {
                                            roleUid = i.value as! String
                                        }
                                    }
                                    
                                    switch roleId {
                                    case "1":
                                        print("Value of role id is 1")
                                    case "2":
                                        print("Value of role id is 2")
                                    case "3":
                                        print("Value of role id is 3")
                                    default:
                                        print("Value of role id is weird check: \(roleId)")
                                    }
                                    
                                    
                                    for i in dict2["data"]!["profile"] as! NSDictionary{
                                        
                                        profileDict.append(i.value)
                                        
                                        if i.key as! String == "logo" {
                                            profileLogo = i.value as! String
                                        }else if i.key as! String == "suburbName" {
                                            profileSuburbName = i.value as! String
                                        }else if i.key as! String == "suburbUid" {
                                            profileSuburbUid = i.value as! String
                                        }else if i.key as! String == "residenceUid" {
                                            profileResidenceUid = i.value as! String
                                        }else if i.key as! String == "profileUid" {
                                            profileProfileUid = i.value as! String
                                        }else if i.key as! String == "profileId" {
                                            profileProfileId = i.value as! String
                                        }
                                    }
                                    
                                    let Logo: String! = profileLogo
                                    self.defaults.set(Logo, forKey: "ProfileLogo")
//                                    KeychainWrapper.standard.set(Logo, forKey: "ProfileLogo")
                                    let ProfileId: String! = profileProfileId
                                    self.defaults.set(ProfileId, forKey: "ProfileId")
//                                    KeychainWrapper.standard.set(ProfileId, forKey: "ProfileId")
                                    
                                    let ProfileUid: String! = profileProfileUid
                                    self.defaults.set(ProfileUid, forKey: "ProfileUid")
//                                    KeychainWrapper.standard.set(ProfileUid, forKey: "ProfileUid")
                                    
                                    let ResidenceUid: String! = profileResidenceUid
                                    self.defaults.set(ResidenceUid, forKey: "ResidenceUid")
//                                    KeychainWrapper.standard.set(ResidenceUid, forKey: "ResidenceUid")
                                    
                                    let SuburbName: String! = profileSuburbName
                                    self.defaults.set(SuburbName, forKey: "SuburbName")
//                                    KeychainWrapper.standard.set(SuburbName, forKey: "SuburbName")
                                    
                                    let SuburbUid: String! = profileSuburbUid
                                    self.defaults.set(SuburbUid, forKey: "SuburbUid")
//                                    KeychainWrapper.standard.set(SuburbUid, forKey: "SuburbUid")
                                    
                                    // Saved Roles
                                    self.defaults.set(roleId, forKey: "roleId")
                                    self.defaults.set(roleUid, forKey: "roleUid")
//                                    KeychainWrapper.standard.set(roleId, forKey: "roleId")
//                                    KeychainWrapper.standard.set(roleUid, forKey: "roleUid")
                                    
                                    var sessiondict = [Any]()
                                    
                                    var userid: String!
                                    var userUid: String!
                                    
                                    for i in dict2["data"]!["session"] as! NSDictionary{
                                        
                                        sessiondict.append(i.value)
                                        if i.key as! String == "userId" {
                                            userid = i.value as! String
                                        }else if i.key as! String == "userUid" {
                                            userUid = i.value as! String
                                        }
                                        
                                    }
                                    
                                    
                                    let UserId: String! = userid
                                    self.defaults.set(UserId, forKey: "userId")
//                                    KeychainWrapper.standard.set(UserId, forKey: "userId")
                                    let UserUid: String! = userUid
                                    self.defaults.set(UserUid, forKey: "userUid")
//                                    KeychainWrapper.standard.set(UserUid, forKey: "userUid")
                                    
                                    var userDataDict = [Any]()
                                    
                                    var userEmail: String!
                                    var userfirstNames: String!
                                    var userLastNames: String!
                                    var userPhoto: String!
                                    for i in dict2["data"]!["userdata"] as! NSDictionary{
                                        
                                        userDataDict.append(i.value)
                                        if i.key as! String == "email" {
                                            userEmail = i.value as! String
                                        }else if i.key as! String == "firstNames" {
                                            userfirstNames = i.value as! String
                                        }else if i.key as! String == "lastNames" {
                                            userLastNames = i.value as! String
                                        }else if i.key as! String == "photo" {
                                            userPhoto = i.value as! String
                                        }
                                    }
                                    
                                    self.defaults.set(userEmail, forKey: "userEmail")
                                    self.defaults.set(userfirstNames, forKey: "userFirstName")
                                    self.defaults.set(userLastNames, forKey: "userLastName")
                                    self.defaults.set(userPhoto, forKey: "userPhoto")
                                    
//                                    KeychainWrapper.standard.set(userEmail, forKey: "userEmail")
//                                    KeychainWrapper.standard.set(userfirstNames, forKey: "userFirstName")
//                                    KeychainWrapper.standard.set(userLastNames, forKey: "userLastName")
//                                    KeychainWrapper.standard.set(userPhoto, forKey: "userPhoto")
                                    self.performSegue(withIdentifier: "pickerToLanding", sender: nil)
                                }

                            }
                            
                            
                        }

                    }
            
                }
            }
        }
    }
}
