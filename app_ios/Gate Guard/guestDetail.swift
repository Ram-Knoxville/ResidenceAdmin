//
//  guestDetail.swift
//  Gate Guard
//
//  Created by Ram on 4/10/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class guestDetail: UIViewController, UITextFieldDelegate {

    
    var guest: Guests!
    
    var firstNames: String!
    var lastNames: String!
    var email: String!
    var id: String!
    var phone: String!
    var guestId: String!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var _email: UITextField!
    @IBOutlet weak var _phone: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstName.delegate = self
        self.lastName.delegate = self
        self._email.delegate = self
        self._phone.delegate = self
        self._phone.keyboardType = UIKeyboardType.numbersAndPunctuation
        
        
        
        if guest != nil {
            if String(describing: guest.firstNames) != "" {
                self.firstName.text = guest.firstNames
            }
            
            if String(describing: guest.lastNames) != "" {
                self.lastName.text = guest.lastNames
            }
            
            if String(describing: guest.email) != "" {
                self._email.text = guest.email
            }
            
            if String(describing: guest.phone) != "" {
                self._phone.text = guest.phone
            }
            
            if String(describing: guest.guestUid) != "" {
                self.guestId = guest.guestUid
            }else {
                self.guestId = ""
            }
        }

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.firstName.resignFirstResponder()
        if textField == firstName { // Switch focus to other text field
            self.lastName.becomeFirstResponder()
        }else if textField == lastName {
            self._email.becomeFirstResponder()
        }else if textField == _email {
            self._phone.becomeFirstResponder()
        }else if textField == _phone {
            self._phone.endEditing(true)
        }
        return true
    }

    @IBAction func backBtnPRessed(_ sender: Any) {
        performSegue(withIdentifier: "guestDetailToList", sender: nil)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        firstNames = self.firstName.text
        lastNames = self.lastName.text
        email = self._email.text
        phone = self._phone.text
        let token = KeychainWrapper.standard.string(forKey: "token")!
        let uid = KeychainWrapper.standard.string(forKey: "userUid")!
        let suburbUid = KeychainWrapper.standard.string(forKey: "SuburbUid")!
        let residenceUid = KeychainWrapper.standard.string(forKey: "ResidenceUid")!
        if guestId == nil {
            guestId = ""
        }
        print("Estos son los parametros:")
        print(token)
        print(guestId)
        print(uid)
        print(firstNames)
        print(lastNames)
        print(email)
        print(phone)
        print(suburbUid)
        print(residenceUid)
        print("Aqui terminan los parametros")
        
        let urlString = "http://api.gateguard.com.mx/api/myGuests/saveGuest"
        
        let parameters: Parameters = [
            "guestUid": guestId,
            "token": token,
            "userUid": uid,
            "firstNames": firstNames,
            "lastNames": lastNames,
            "eMail": email,
            "phone": phone,
            "suburbUid": suburbUid,
            "residenceUid": residenceUid
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON : \(JSON)")
                self.performSegue(withIdentifier: "guestDetailToList", sender: nil)
            }
            
        }
        
        
        
    }
    
}
