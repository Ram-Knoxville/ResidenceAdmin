//
//  accessRegistryVC.swift
//  Gate Guard
//
//  Created by Ram on 6/26/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire

class accessRegistryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var registryTable: UITableView!
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    var requests = [AccessRequest]()
    var totalRequests = [[String : Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuBtn.target = SWRevealViewController()
        
        self.menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.registryTable.delegate = self
        self.registryTable.dataSource = self
        self.registryTable.tableFooterView = UIView(frame: .zero)
        
        self.getData()
        
    }

    func getData() {
        
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        let residenceUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")!
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/getVisitorWaitingMobile"
        
        let parameters: Parameters = [
            "residenceUid": residenceUid,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                print("Aqui empieza el diccionario \(dict)")
                
                if let resultado = dict["data"]!["segundo"] as? [[String : Any]] {

                    for i in resultado {
                        
                        print("Valor de i = \(i)")
                        
                        self.totalRequests.append(i)
                        
                    }
                    
                    self.dataParser()
                    
                }else {
                    print("No hay data")
                }
                
            }
            
        }
        
    }
    
    func dataParser(){
        
        for i in totalRequests {
            
            let access: String! = i["access"]! as! String
            let address: String! = i["address"] as! String
            let contextImg: String! = i["contextImg"]! as! String
            let date: String! = i["date"]! as! String
            let driver: String! = i["driver"]! as! String
            let plateImg: String! = i["plateImg"]! as! String
            let time: String! = i["time"]! as! String
            let uid: String! = i["uid"]! as! String
            let wait: String! = i["wait"]! as! String
            
            let requestss = AccessRequest(access: access, address: address, contextImg: contextImg, date: date, driver: driver, plateImg: plateImg, time: time, uid: uid, wait: wait)
            
            self.requests.append(requestss)
            
            self.registryTable.reloadData()
            
        }
        self.registryTable.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AccessRequestCell {
            
            let request: AccessRequest!
            
            request = requests[indexPath.row]
            cell.configureCell(Acceso: request)
            
            return cell
        }else {
            return UITableViewCell()
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("No me presiones weee ! hahahha Sueltame alv !")
    }

}
