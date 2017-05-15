//
//  alarmEventsVC.swift
//  Gate Guard
//
//  Created by Ram on 4/17/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire

class alarmEventsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    var clasifications = ["Todas"]
    var events = ["Todos"]
    
    @IBOutlet weak var datePickerOne: UIDatePicker!
    
    @IBOutlet weak var datePickerTwo: UIDatePicker!
    
    @IBOutlet weak var clasificationPicker: UIPickerView!
    
    @IBOutlet weak var alarmEventsPicker: UIPickerView!
    
    var fullClasifications = [[String : Any]]()
    
    var alarmEvents: AlarmEvents!
    
    var totalAlarmEvents = [[String : Any]]()
    
    var fullEvents = [[String : Any]]()
    
    var totalEvents = [String : Any]()
    
    var clasificationUidSelected: String!
    
    var eventUidSelected: String!
    
    var filterFrom: String!
    var filterTo: String!
    var clasification: String!
    var event: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.clasificationPicker.delegate = self
        self.clasificationPicker.dataSource = self
        
        self.alarmEventsPicker.delegate = self
        self.alarmEventsPicker.dataSource = self
        
        
        getAlarmClasifications()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        switch pickerView {
        case self.clasificationPicker:
            return 1
        case self.alarmEventsPicker:
            return 1
        default:
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case self.clasificationPicker:
            return self.clasifications.count
        case self.alarmEventsPicker:
            return self.events.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case self.clasificationPicker:
            return clasifications[row]
        case self.alarmEventsPicker:
            return events[row]
        default:
            return "No Data"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case self.clasificationPicker:
            print("hola mundo Clasification")
            if row == 0 {
                self.clasificationUidSelected = ""
                getAlarmEvents(clasificationUid: self.clasificationUidSelected)
            }else {
                let rowss = row
                let number = -1
                let result = rowss + number
                print(result)
                self.clasificationUidSelected = self.fullClasifications[result]["uid"] as! String
                getAlarmEvents(clasificationUid: self.clasificationUidSelected)
            }
            
        case self.alarmEventsPicker:
            if row == 0 {
                self.eventUidSelected = ""
                print("hola mundo Event")
            }else {
                let rowss = row
                let number = -1
                let result = rowss + number
                print(result)
                self.eventUidSelected = self.fullEvents[result]["uid"] as! String
                print("hola mundo Event")
            }
            
        default:
            print("hola mundo Default")
        }
    }
    
    func getAlarmClasifications() {
        let token: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")
        
        let urlString = "http://api.gateguard.com.mx/api/AlarmPanels/getAlarmClassificationsMobile"
        
        let parameters: Parameters = [
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            if let JSON = response.result.value {
                print("Resultado de clasificaciones: \(JSON)")
            }
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                for i in dict["clasifications"] as! [[String : Any]]{
                    
                    self.fullClasifications.append(i)
                }
                
                self.manageClasifications()
            }
        }
    }
    
    func manageClasifications(){
        let clasification = fullClasifications
        for c in clasification {
            self.clasifications.append(c["name"] as! String)
        }
        
        
        self.clasificationPicker.reloadAllComponents()
    }
    
    
    func getAlarmEvents(clasificationUid: String) {
        
        let token: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")
        
        let urlString = "http://api.gateguard.com.mx/api/AlarmPanels/getAlarmEventsDbMobile"
        
        let parameters: Parameters = [
            "token": token,
            "classificationUid": clasificationUid
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            if let JSON = response.result.value {
                print("Resultado de Eventos: \(JSON)")
            }
            
            let result = response.result
            self.fullEvents = [[String : Any]]()
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                for i in dict["events"] as! [[String : Any]]{
                    
                    self.fullEvents.append(i)
                }
                
                self.manageEvents()
            }

            
        }

    }
    
    func manageEvents() {
        let event = fullEvents
        self.events = ["Todos"]
        for e in event {
            self.events.append(e["name"] as! String)
        }
        
        print("Estos son los eventos guardados : \(events)")
        
        self.alarmEventsPicker.reloadAllComponents()
    }
    
    @IBAction func getDataFromApi(_ sender: Any) {
        
        clasification = self.clasificationUidSelected!
        event = self.eventUidSelected!
        
        let formatter = DateFormatter()
        formatter.calendar = datePickerOne.calendar
        formatter.dateFormat = "yyyy/MM/dd"
        filterFrom = formatter.string(from: datePickerOne.date)
        
        formatter.calendar = datePickerTwo.calendar
        formatter.dateFormat = "yyyy/MM/dd"
        filterTo = formatter.string(from: datePickerTwo.date)
        
        print("desde : \(filterFrom)")
        print("Hasta: \(filterTo)")
        
        performSegue(withIdentifier: "alarmRegistry", sender: (filterFrom, filterTo, clasification, event))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alarmRegistry" {
            if let alarmRegistry = segue.destination as? alarmRegistryVC {
                alarmRegistry.filterFrom = filterFrom
                alarmRegistry.filterTo = filterTo
                alarmRegistry.clasification = clasification
                alarmRegistry.event = event
            }
        }
    }
    
}
