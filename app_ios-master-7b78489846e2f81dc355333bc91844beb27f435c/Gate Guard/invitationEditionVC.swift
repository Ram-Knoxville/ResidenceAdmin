//
//  invitationEditionVC.swift
//  Gate Guard
//
//  Created by Ram on 4/14/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire

class invitationEditionVC: UIViewController {
    
    @IBOutlet weak var timePicker1: UIDatePicker!
    @IBOutlet weak var timePicker2: UIDatePicker!
    
    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet weak var datePicker2: UIDatePicker!
    
    @IBOutlet weak var allDaySwitch: UISwitch!
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    let formatter = DateFormatter()
    var startTime: String!
    var endTime: String!
    var allDayValue: String!
    
    var firstName: String!
    var lastName: String!
    var email: String!
    var guestId: String!
    
    var guest: Guests!
    
    var invitation: String!
    
    var invitationId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))

        
        self.timePicker1.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        self.timePicker2.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        
        self.changeDateTitles()
        
        checkGuestValues()
    }
    
    func checkGuestValues(){
        if guest != nil {
            if String(describing: guest.firstNames) != "" {
                self.firstName = guest.firstNames
            }
            
            if String(describing: guest.lastNames) != "" {
                self.lastName = guest.lastNames
            }
            
            if String(describing: guest.email) != "" {
                self.email = guest.email
            }
            
            if String(describing: guest.id) != "" {
                self.guestId = guest.id
            }else {
                self.guestId = ""
            }
        }else {
            firstName = ""
            lastName = ""
            email = ""
            guestId = ""
        }
        
        if invitation != nil {
            invitationId = invitation
        }else {
            invitationId = ""
        }
    }
    
    func changeDateTitles() {
        
        if KeychainWrapper.standard.string(forKey: "startDate") != nil {
            
        }else{
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let startDate = formatter.string(from: date)
        }
        
        if KeychainWrapper.standard.string(forKey: "endDate") != nil {
            
        }else{
            
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goBackSegue", sender: nil)
    }
    
    @IBAction func dateConfig1Pressed(_ sender: Any) {
        performSegue(withIdentifier: "calendarView", sender: nil)
        
    }
    
    @IBAction func dateConfig2Pressed(_ sender: Any) {
        performSegue(withIdentifier: "calendarView2", sender: nil)
    }
    
    
    @IBAction func startTimePressed(_ sender: Any) {
        self.startTime = self.formatter.string(from: self.timePicker1.date)
        print("Esta es la hora de entrada: \(startTime)")
    }
    
    @IBAction func endTimePressed(_ sender: Any) {
        self.endTime = self.formatter.string(from: self.timePicker2.date)
        print("Esta es la hora de salida : \(endTime)")
    }
    
    @IBAction func startDatePressed(_ sender: Any) {
        self.startTime = self.formatter.string(from: self.datePicker1.date)
        print("Esta es la fecha de inicio : \(startTime)")
    }
    
    @IBAction func endDatePressed(_ sender: Any) {
        self.endTime = self.formatter.string(from: self.datePicker2.date)
        print("Esta es la fecha de salida : \(endTime)")
    }
    
    @IBAction func sendInvitation(sender: AnyObject) {
        
        if allDaySwitch.isOn {
            allDayValue = "1"
        } else {
            allDayValue = "0"
        }
        
        
        if invitationId != nil {
            //Send request to server
            
            let token: String! = KeychainWrapper.standard.string(forKey: "token")!
            
            
            let urlString = "http://api.gateguard.com.mx/api/myGuests/sendInvitation"
            
            let parameters: Parameters = [
                "token": token,
                "invitationId": invitationId,
                "dateStart": "20170420",
                "dateEnd": "20170425",
                "hourStart": "",
                "hourEnd": "",
                "allDay": allDayValue
            ]
            
            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON : \(JSON)")
                }
                
            }
            
            KeychainWrapper.standard.removeObject(forKey: "startDate")
            KeychainWrapper.standard.removeObject(forKey: "endDate")
            performSegue(withIdentifier: "goBackSegue", sender: nil)
            
        }else {
            //Send request to server
            
            let token: String! = KeychainWrapper.standard.string(forKey: "token")!
            let suburbUid: String! = KeychainWrapper.standard.string(forKey: "SuburbUid")!
            let residenceUid: String! = KeychainWrapper.standard.string(forKey: "ResidenceUid")!
            var myGuest = ["id": "", "firstNames": "", "lastNames": "", "eMail": ""]
            print("Valores")
            print(self.guestId)
            print(firstName)
            print(lastName)
            print(email)
            myGuest["id"] = self.guestId
            myGuest["firstNames"] = self.firstName
            myGuest["lastNames"] = self.lastName
            myGuest["eMail"] = self.email
            
            let urlString = "http://api.gateguard.com.mx/api/myGuests/sendInvitation"
            
            let parameters: Parameters = [
                "token": token,
                "guest": myGuest,
                "dateStart": "",
                "dateEnd": "",
                "hourStart": "",
                "hourEnd": "",
                "allDay": allDayValue,
                "suburbUid": suburbUid,
                "residenceUid": residenceUid
            ]
            
            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON : \(JSON)")
                }
                
            }
            
            KeychainWrapper.standard.removeObject(forKey: "startDate")
            KeychainWrapper.standard.removeObject(forKey: "endDate")
            performSegue(withIdentifier: "goBackSegue", sender: nil)
        }
        
    }

}
