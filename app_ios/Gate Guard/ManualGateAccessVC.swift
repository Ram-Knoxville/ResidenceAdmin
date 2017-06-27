//
//  ManualGateAccessVC.swift
//  Gate Guard
//
//  Created by Ram on 5/22/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire

class ManualGateAccessVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var doorsCollection: UICollectionView!
    
    var totalDoors = [[String: Any]]()
    var filteredDoors = [Doors]()
    var inSearchMode = false
    var doors = [Doors]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.doorsCollection.delegate = self
        self.doorsCollection.dataSource = self
        
        
        self.getDoors()
        
    }
    
    func getDoors(){
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        let suburbUid: String! = UserDefaults.standard.string(forKey: "SuburbUid")!
        
        let urlString = "http://api.gateguard.com.mx/api/Access/getSuburbDoorsMobile"
        
        let parameters: Parameters = [
            "suburbUid": suburbUid,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                print("Aqui empieza el diccionario \(dict)")
                
                
                if let resultado = dict["data"]!["puertas"] as? [[String : Any]] {
                    
                    for i in resultado {
                        print("Valor de i = \(i)")
                        self.totalDoors.append(i)
                    }
                    
                    self.dataParser()
                    
                }else {
                    let alerta = Alertas()
                    alerta.showAlertMessage(vc: self, titleStr: "Mensaje", messageStr: "No existen registros de puertas de acceso en este suburbio")
                }
                
                
                
            }
            
        }
        
    }
    
    func dataParser(){
        print(totalDoors)
        
        for i in totalDoors {
            
            let doorName: String! = i["name"]! as! String
            let doorType: String! = i["doorType"]! as! String
            let pedestrian: String! = i["pedestrian"]! as! String
            let uid: String! = i["uid"]! as! String
            
            let doorss = Doors(doorType: doorType, name: doorName, pedestrian: pedestrian, uid: uid)
            
            self.doors.append(doorss)
            
            self.doorsCollection.reloadData()

        }
        self.doorsCollection.reloadData()
    }
    
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DoorCell {
            
            let door: Doors!
            
            if inSearchMode {
                
                door = filteredDoors[indexPath.row]
                cell.configureCell(door: door)
                
            }else {
                
                door = doors[indexPath.row]
                cell.configureCell(door: door)
            }
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredDoors.count
        }else{
            return doors.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 347, height: 93)
    }


}
