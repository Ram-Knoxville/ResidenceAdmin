//
//  GuestsVC.swift
//  Gate Guard
//
//  Created by Ram on 4/10/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire

class GuestsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var newGuestBtnStyle: UIButton!
    @IBOutlet weak var guestsList: UITableView!
    
    var guests = [String]()
    var _guests = [Guests]()
    var apiResult = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.newGuestBtnStyle.layer.cornerRadius = 3
        
        
        
        self.guestsList.delegate = self
        self.guestsList.dataSource = self
        self.guestsList.tableFooterView = UIView(frame: .zero)
        
        self.getGuestsList()
        
    }
    
    func getGuestsList(){
        //Send request to server
        
        let token: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")!
        let residenceUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")!//KeychainWrapper.standard.string(forKey: "ResidenceUid")!
        
        
        let urlString = "http://api.gateguard.com.mx/api/myGuests/getGuestMobile"
        
        let parameters: Parameters = [
            "token": token,
            "residenceUid": residenceUid
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON : \(JSON)")
            }
            
            let result = response.result
            
            
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if dict["status"] as? String != "OK"{
                    
                }else if dict["status"] as? String == "OK"{
                    if dict["data"]!["guest"] as! [[String: Any]] != nil {
                        for i in dict["data"]!["guest"] as! [[String : Any]]{
                            
                            print("Contador: \(i.count)")
                            self.apiResult.append(i)
                            
                        }
                        
                        self.dataParser()
                    }else {
                        let alert = Alertas()
                        alert.showAlertMessage(vc: self, titleStr: "Mensaje", messageStr: "No cuenta con invitados registrados")
                    }
                    
                }
            }
        }
        
    }
    
    func dataParser(){
        let result = apiResult
        
        for r in result {

            let name: String! = r["firstNames"] as! String
            let lastNames: String! = r["lastNames"] as! String
            let email = r["eMail"] as! String
            let id = r["id"] as! String
            let phone = r["phone"] as! String
            let fullName = "\(name!) \(lastNames!)"
            let guestUid = r["uid"] as! String
            
            self.guests.append(fullName)
            self.guestsList.reloadData()
            
            let guest = Guests(firstNames: name, lastNames: lastNames, email: email, id: id, phone: phone, guestUid: guestUid)
            _guests.append(guest)
        }
    }
        
        

    @IBAction func newGuestBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "NewGuestDetail", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let guest = guests[indexPath.row]
        cell.textLabel?.text = guest
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { action, index in
            print("more button tapped")
            var guest: Guests!
            
            guest = self._guests[indexPath.row]
            
            self.performSegue(withIdentifier: "NewGuestDetail", sender: guest)
            
        }
        edit.backgroundColor = UIColor.darkGray
        
        let invite = UITableViewRowAction(style: .normal, title: "Invitar") { action, index in
            print("favorite button tapped")
            var guest: Guests!
            
            guest = self._guests[indexPath.row]

            self.performSegue(withIdentifier: "sendInviteSegue", sender: guest)
        }
        invite.backgroundColor = #colorLiteral(red: 0.1516869267, green: 0.4271139008, blue: 0.6180797906, alpha: 1)
        
        let delete = UITableViewRowAction(style: .normal, title: "Borrar") { action, index in
            print("share button tapped")
            var guest: Guests!
            
            guest = self._guests[indexPath.row]
            
            let token: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")!
            let guestUid: String! = guest.guestUid
            let uid: String! = UserDefaults.standard.string(forKey: "userUid")!//KeychainWrapper.standard.string(forKey: "userUid")!
            let suburbUid: String! = UserDefaults.standard.string(forKey: "SuburbUid")!//KeychainWrapper.standard.string(forKey: "SuburbUid")!
            let residenceUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")!//KeychainWrapper.standard.string(forKey: "ResidenceUid")
            
            print("Empiezan parametros")
            print(token)
            print(guestUid)
            print(uid)
            print(suburbUid)
            print(residenceUid)
            print("terminan parametros")
            
            
            let urlString = "http://api.gateguard.com.mx/api/myGuests/deletedGuest"
            
            let parameters: Parameters = [
                "token": token,
                "guestUid": guestUid,
                "userUid": uid,
                "suburUid": suburbUid,
                "residenceUid": residenceUid
            ]
            
            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON : \(JSON)")
                }
                
                self.guests = [String]()
                self._guests = [Guests]()
                self.apiResult = [[String: Any]]()
                
                self.viewDidLoad()
            }
        }
        delete.backgroundColor = #colorLiteral(red: 0.7820233185, green: 0.3065785842, blue: 0.1877702123, alpha: 1)
        
        return [edit, invite, delete]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewGuestDetail" {
            if let detailVC = segue.destination as? guestDetail {
                if let guest = sender as? Guests {
                    detailVC.guest = guest
                }
            }
        }else if segue.identifier == "sendInviteSegue" {
            if let detailVC = segue.destination as? sendInviteVC {
                if let guest = sender as? Guests {
                    detailVC.guest = guest
                }
            }
        }
    }

    
}
