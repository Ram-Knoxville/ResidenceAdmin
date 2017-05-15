//
//  alarmRegistryVC.swift
//  Gate Guard
//
//  Created by Ram on 4/19/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire

class alarmRegistryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var alarmCollectionList: UITableView!
    
    var attendedAlarm: Bool!
    
    var filterFrom: String!
    var filterTo: String!
    var clasification: String!
    var event: String!
    let residenceUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")!//KeychainWrapper.standard.string(forKey: "ResidenceUid")!
    let token: String! = UserDefaults.standard.string(forKey: "token")//KeychainWrapper.standard.string(forKey: "token")
    
    var totalAlarms = [[String : Any]]()
    var alarms = [AlarmEvents]()
    
    var inSearchMode = false
    var filteredAlarms = [AlarmEvents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alarmCollectionList.delegate = self
        self.alarmCollectionList.dataSource = self
        self.alarmCollectionList.tableFooterView = UIView(frame: .zero)
        
        retrieveData(token: token, residenceUid: residenceUid, filterFrom: filterFrom, filterTo: filterTo, clasification: clasification, event: event)
    }
    
    
    func retrieveData(token: String, residenceUid: String, filterFrom: String, filterTo: String, clasification: String, event: String){
        
        let tokenString: String! = token
        let residenceUidString: String! = residenceUid
        let filteredFromString: String! = filterFrom
        let filteredToString: String! = filterTo
        let clasificationString: String! = clasification
        let eventString: String! = event
        
        let urlString = "http://api.gateguard.com.mx/api/AlarmPanels/getAlarmEventsInResidenceMobile"
        
        let parameters: Parameters = [
            "token": tokenString,
            "residenceUid": residenceUidString,
            "filterFrom": filteredFromString,
            "filterTo": filteredToString,
            "classification":clasificationString,
            "event":eventString
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                
                print("Resultado de consulta : \(JSON)")
                
                if let dict = JSON as? Dictionary<String, AnyObject>{
                    
                    for i in dict["records"] as! [[String : Any]]{

                        self.totalAlarms.append(i)
                        
                    }
                    self.dataParser()
                }
            }
            
        }
        
    }
    
    func dataParser(){
        
        let alarm = totalAlarms
        
        for a in alarm{

            let ack: String! = a["ack"]! as! String
            let date: String! = a["date"] as! String
            let eventClass: String! = a["eventClass"] as! String
            let eventColor: String! = a["eventColor"] as! String
            let eventName: String! = a["eventName"] as! String
            let eventNumber: String! = a["eventNumber"] as! String
            let time: String! = a["time"] as! String
            let toReport: String! = a["toReport"] as! String
            let type: String! = a["type"] as! String
            let uid: String! = a["uid"] as! String
            
            let alarmss = AlarmEvents(ack: ack, date: date, eventClass: eventClass, eventColor: eventColor, eventName: eventName, eventNumber: eventNumber, time: time, toReport: toReport, type: type, uid: uid)
            alarms.append(alarmss)
            
            alarmCollectionList.reloadData()
            
        }
    }
    
    // MARK: - TableVIew Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredAlarms.count
        }else{
            return alarms.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if inSearchMode {
            let alarm = filteredAlarms[indexPath.row]
            
            cell.textLabel?.text = alarm.eventName + " " + alarm.date + " " + alarm.time
            cell.textLabel?.textColor = UIColor.white
            return cell

        }else {
            let alarm = alarms[indexPath.row]
            cell.textLabel?.text = alarm.eventName
//            cell.textLabel?.textColor = UIColor.white
            return cell

        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alarm = alarms[indexPath.row]
        
        performSegue(withIdentifier: "alarmRegistryDetail", sender: alarm)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alarmRegistryDetail" {
            if let AlarmRegistryDetailVC = segue.destination as? alarmRegistryDetailVC {
                if let alarmRegistry = sender as? AlarmEvents {
                    AlarmRegistryDetailVC.AlarmEvent = alarmRegistry
                }
            }
        }
    }
    
    @IBAction func dismissViewController(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
