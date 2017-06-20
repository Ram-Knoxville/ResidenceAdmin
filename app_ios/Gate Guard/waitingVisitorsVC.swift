//
//  waitingVisitorsVC.swift
//  Gate Guard
//
//  Created by Ram on 6/14/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire

class waitingVisitorsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var requestsCollection: UICollectionView!
    
    var totalRequests = [[String: Any]]()
    var requests = [AccessRequest]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        requestsCollection.delegate = self
        requestsCollection.dataSource = self

        getData()
    }
    
    func getData() {
        
        let token: String! = UserDefaults.standard.string(forKey: "token")!
        let suburbUid: String! = UserDefaults.standard.string(forKey: "SuburbUid")!
        
        let urlString = "http://api.gateguard.com.mx/api/visitors/getVisitorWaitingMobile"
        
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
                
                for i in dict["data"]!["segundo"] as! [[String : Any]]{
                    
                    print("Valor de i = \(i)")
                    
                    self.totalRequests.append(i)
                    
                }
                
                self.dataParser()
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
            
            self.requestsCollection.reloadData()
            
        }
        self.requestsCollection.reloadData()
    }

    
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AccessRequestCell {
            
            let request: AccessRequest!
            
                request = requests[indexPath.row]
                cell.configureCell(Acceso: request)
            
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return requests.count
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 390, height: 130)
    }

    func reloadData() {
        self.requestsCollection.reloadData()
    }

    @IBAction func allowAccessBtnPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Mensaje", message: "Acceso Aprobado, \n porfavor refresque el registro", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func denyAccessBtnPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Mensaje", message: "Acceso Denegado, \n porfavor refresque el registro", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func refresh(_ sender: Any) {
         print("Hello World")
        self.totalRequests = [[String: Any]]()
        self.requests = [AccessRequest]()
        getData()
    }


}
