//
//  AccessReportVC.swift
//  Gate Guard
//
//  Created by Ram on 4/20/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire

class AccessReportVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var accessRegistryTable: UITableView!
    
    let token: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")!
    let residenceUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")!//KeychainWrapper.standard.string(forKey: "ResidenceUid")
    
    var feedMeArray = [Any]()
    
    var dateFrom: Date!
    var dateTo: Date!
    
    var registry = [[String : Any]]()
    var registryRecords = [residenceAccessLog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.accessRegistryTable.delegate = self
        self.accessRegistryTable.dataSource = self
        self.accessRegistryTable.tableFooterView = UIView(frame: .zero)
        
        self.getData(token: token, residenceUid: residenceUid)
        
    }
    
    func getData(token: String, residenceUid: String) {
        
        dateFrom = self.feedMeArray[0] as! Date
        dateTo = self.feedMeArray[1] as! Date
        
        let formatterFrom = DateFormatter()
        formatterFrom.dateStyle = .short
        
        print("Aqui viene el formato From")
        print(formatterFrom.string(from: dateFrom))
        
        let formatterTo = DateFormatter()
        formatterTo.dateStyle = .short
        
        print("Aqui viene el formato To")
        print(formatterTo.string(from: dateTo))
        
        let plate: String! = self.feedMeArray[2] as! String
        let name: String! = self.feedMeArray[3] as! String
        
        let urlString = "http://api.gateguard.com.mx/api/Access/getAccessToResidenceMobile"
        
        let parameters: Parameters = [
            "token": token,
            "residenceUid": residenceUid,
            "dateFrom": formatterFrom.string(from: dateFrom),
            "dateTo": formatterTo.string(from: dateTo),
            "plate": plate,
            "name": name
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            let result = response.result
            
            print(response.result.value!)
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                for i in dict["data"]!["records"] as! [[String : AnyObject]]{
                    self.registry.append(i)
                }
                self.dataParser()
            }
            
        }
        
    }
    
    
    func dataParser(){
        let records = registry
        for r in records{
            let accessGranted: String! = r["accessGranted"] as! String
            let accessType: String! = r["accessType"] as! String
            let card: String! = r["card"] as! String
            let date: String! = r["date"] as! String
            let dateFull: String! = r["dateFull"] as! String
            
            //let doorDirection: String! = r["doorDirection"] as! String
            //let doorEnter: String! = r["doorEnter"] as! String
            let id: String! = r["id"] as! String
            let name: String! = r["name"] as! String
            let plate: String! = r["plate"] as! String
            let time: String! = r["time"] as! String
            let type: Int = r["type"] as! Int
            let uid: String! = r["uid"] as! String
            
            let record = residenceAccessLog(accessGranted: accessGranted, accessType: accessType, card: card, date: date, dateFull: dateFull, doorDirection: "0", doorEnter: "0", id: id, name: name, plate: plate, time: time, type: type, uid: uid)
            
            registryRecords.append(record)
            accessRegistryTable.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registryRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as? ResidenceAccessLogCell {
            
            let registries: residenceAccessLog!
            
            registries = registryRecords[indexPath.row]
            cell.configureCell(accessLog: registries)
            
            
            return cell
        }else {
            return UITableViewCell()
        }
        
        
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
