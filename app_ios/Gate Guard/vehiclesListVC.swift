//
//  vehiclesListVC.swift
//  Gate Guard
//
//  Created by Ram on 4/7/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import SwiftGifOrigin

class vehiclesListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var vehiclesList: UICollectionView!
    
    @IBOutlet weak var vehicleSearchBar: UISearchBar!
    
    @IBOutlet weak var activityIndicator: UIImageView!
    
    var vehicles = [Vehicles]()
    var filteredVehicles = [Vehicles]()
    var inSearchMode = false
    
    var totalesVehiculo = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))

        self.activityIndicator.isHidden = false
        self.activityIndicator.loadGif(name: "loading")
        
        self.vehiclesList.delegate = self
        self.vehiclesList.dataSource = self
        self.vehicleSearchBar.delegate = self
        
        self.vehicleSearchBar.returnKeyType = UIReturnKeyType.done
        self.vehicleSearchBar.keyboardAppearance = UIKeyboardAppearance.dark
        
        
        
        
        
        let residenceUid = UserDefaults.standard.string(forKey: "ResidenceUid")!
        let token = UserDefaults.standard.string(forKey: "token")!
        let suburbUid = UserDefaults.standard.string(forKey: "SuburbUid")!
        
        self.getVehicles(residenceUid: residenceUid, token: token, suburbUid: suburbUid)
    }
    
    func getVehicles(residenceUid: String, token: String, suburbUid: String) {
        
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/Vehicles/getVehiclesMobile"
        
        let parameters: Parameters = [
            "residenceUid": residenceUid,
            "token": token,
            "suburbUid": suburbUid
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON : \(JSON)")
            }
            
            let result = response.result
            
            
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if dict["status"] as? String != "OK"{
                    
                }else if dict["status"] as? String  == "OK"{
                    
                    for i in dict["data"]!["vehicles"] as! [[String : Any]]{
                        
                        print(i.count)
                        self.totalesVehiculo.append(i)
                        
                    }
                    print("ya la armaste we checa este pedo \(self.totalesVehiculo)")
                    self.dataParser()
                }
            }
        }
    }
    
    func dataParser() {
        
        let vehicle = totalesVehiculo
        print("Checate esto: \(vehicle)")
        for v in vehicle{
            
            let accessGranted: String! = v["accessGranted"] as! String
            let brandId: String! = v["brandId"] as! String
            let brandName: String! = v["brandName"] as! String
            let color: String! = v["color"] as! String
            let id: String! = v["id"] as! String
            let logo: String! = v["logo"] as! String
            let model: String! = v["model"] as! String
            let plate: String! = v["plate"] as! String
            let relationUid: String! = v["relationUid"] as! String
            let statusGps: String! = v["statusGPS"] as! String
            let uid: String! = v["uid"] as! String
            
            let vehicless = Vehicles(accessGranted: accessGranted, brandId: brandId, brandName: brandName, color: color, id: id, logo: logo, model: model, plate: plate, relationUid: relationUid, statusGps: statusGps, uid: uid)
            vehicles.append(vehicless)
            vehiclesList.reloadData()
        }
        self.activityIndicator.isHidden = true
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? VehicleCell {
            
            let vehicle: Vehicles!
            
            if inSearchMode {
                
                vehicle = filteredVehicles[indexPath.row]
                cell.configureCell(vehicle: vehicle)
                
                
                
            }else {
                
                vehicle = vehicles[indexPath.row]
                cell.configureCell(vehicle: vehicle)
                
            }
            
            
            return cell
            
        }else{
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredVehicles.count
        }else{
            return vehicles.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    // MARK: - Search Bar Functions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if vehicleSearchBar.text == nil || vehicleSearchBar.text == "" {
            inSearchMode = false
            vehiclesList.reloadData()
            view.endEditing(true)
            
        }else {
            inSearchMode = true
            
            filteredVehicles = vehicles.filter({$0.brandName.range(of: self.vehicleSearchBar.text!) != nil})
            vehiclesList.reloadData()
            
        }
    }


}
