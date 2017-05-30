//
//  invitationEditionVC.swift
//  Gate Guard
//
//  Created by Ram on 4/14/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire

class invitationEditionVC: UIViewController {
    
    @IBOutlet weak var dateFrom: UIDatePicker!
    @IBOutlet weak var dateTo: UIDatePicker!
    
    @IBOutlet weak var timeFrom: UIDatePicker!
    @IBOutlet weak var timeTo: UIDatePicker!
    
    @IBOutlet weak var allDaySwitch: UISwitch!
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))

    }
    
    
    @IBAction func sendInvitation(sender: AnyObject) {
        
        let token: String! = UserDefaults.standard.string(forKey: "token")
        
        let suburbUid: String! = UserDefaults.standard.string(forKey: "SuburbUid")
        let residenceUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateFromString = formatter.string(from: self.dateFrom.date)
        let dateToString = formatter.string(from: self.dateTo.date)
        let timeFromString = formatter.string(from: self.timeFrom.date)
        let timeToString = formatter.string(from: self.timeTo.date)
        
        let invitationId: String! = UserDefaults.standard.string(forKey: "invitationId")
        
        if self.allDaySwitch.isOn {
            
            let urlString = "http://api.gateguard.com.mx/api/myGuests/sendInvitation"
            
            let parameters: Parameters = [
                "token": token,
                "guestUid": "0",
                "suburbUid": suburbUid,
                "residenceUid": residenceUid,
                "invitationId": invitationId,
                "dateStart": dateFromString,
                "dateEnd": dateToString,
                "hourStart": "",
                "hourEnd": "",
                "allDay": "1"
            ]
            
            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON : \(JSON)")
                }
                
            }
            
        }else {
            
            let urlString = "http://api.gateguard.com.mx/api/myGuests/sendInvitation"
            
            let parameters: Parameters = [
                "token": token,
                "guestUid": "0",
                "suburbUid": suburbUid,
                "residenceUid": residenceUid,
                "invitationId": invitationId,
                "dateStart": dateFromString,
                "dateEnd": dateToString,
                "hourStart": timeFromString,
                "hourEnd": timeToString,
                "allDay": "0"
            ]
            
            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON : \(JSON)")
                }
            }
        }
        performSegue(withIdentifier: "goBackSegue", sender: nil)
    }

}
