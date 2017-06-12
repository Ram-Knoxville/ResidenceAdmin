//
//  InvitationsListVC.swift
//  Gate Guard
//
//  Created by Ram on 4/13/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class InvitationsListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var invitationsCollection: UICollectionView!
    
    var totalInvitations = [[String: Any]]()
    var filteredInvitations = [Invitations]()
    var inSearchMode = false
    var invitations = [Invitations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.invitationsCollection.delegate = self
        self.invitationsCollection.dataSource = self
        
        self.getInvitations()
        
    }
    
    
    func getInvitations() {
        
        let token: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")!
        let residentUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")!//KeychainWrapper.standard.string(forKey: "ResidenceUid")!
        
         print("This is the residenceUid you're getting : \(residentUid!)")
        
        
        let urlString = "http://api.gateguard.com.mx/api/myGuests/getInvitations"
        
        let parameters: Parameters = [
         "token": token,
         "residenceUid": residentUid
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON : \(JSON)")
            }
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                print("Este es el diciconario \(dict)")
                
                if dict["err"] as? String == nil {
                        for i in dict["data"]!["guestConfirmation"] as! [[String : Any]]{
                            
                            print(i.count)
                            self.totalInvitations.append(i)
                            
                        }
                    
                        self.dataParser()
                        
                        print("ya la armaste we checa este pedo \(self.totalInvitations)")
                    
                    
                }else if dict["err"] as? String != nil {
                    
                    let alerta = Alertas()
                    alerta.showAlertMessage(vc: self, titleStr: "Mensaje", messageStr: "No existen registros de invitaciones")
                }
            }
        }
    }
    
    func showAlertWithTitle(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }

    
    func dataParser(){
        for i in totalInvitations {
            
            let invitationUid: String! = i["invitationId"]! as! String
            let dateInvitationIni: String! = i["dateIni"]! as! String
            let dateInvitationEnd: String! = i["dateEnd"]! as! String
            let confirmed: String! = i["confirmed"]! as! String
            let plate: String! = i["plate"]! as! String
            let guestName: String! = i["guestName"]! as! String
            
            
            let invitationss = Invitations(invitationUid: invitationUid, dateInvitationIni: dateInvitationIni, dateInvitationEnd: dateInvitationEnd, confirmed: confirmed, plate: plate, guestName: guestName)
            
            invitations.append(invitationss)
            
            invitationsCollection.reloadData()
        }
            invitationsCollection.reloadData()
    }
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? InvitationsCell {
            
            let invitation: Invitations!
            
            if inSearchMode {
                
                invitation = filteredInvitations[indexPath.row]
                cell.configureCell(invitation: invitation)
                
            }else {

                invitation = invitations[indexPath.row]
                cell.configureCell(invitation: invitation)
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
            return filteredInvitations.count
        }else{
            return invitations.count
        }

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 305, height: 231)
    }
    
    // Sort Data
    
    @IBAction func sortConfirmedBtnPressed(_ sender: Any) {
        
        inSearchMode = true
        
        filteredInvitations = self.invitations.filter({$0.confirmed.range(of: "1") != nil })
        invitationsCollection.reloadData()
        
    }
    
    @IBAction func sortCanceledBtnPressed(_ sender: Any) {
        inSearchMode = true
        
        filteredInvitations = self.invitations.filter({$0.confirmed.range(of: "2") != nil })
        invitationsCollection.reloadData()
    }

    @IBAction func sortPendingBtnPressed(_ sender: Any) {
        
        inSearchMode = true
        
        filteredInvitations = self.invitations.filter({$0.confirmed.range(of: "0") != nil })
        invitationsCollection.reloadData()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Mensaje", message: "Invitación Cancelada", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resendInvite(_ sender: Any) {
        let alert = UIAlertController(title: "Mensaje", message: "Invitación Re-enviada", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {

        performSegue(withIdentifier: "editInvitation", sender: nil)
        
    }
    
    func reloadData(){
        self.invitationsCollection.reloadData()
    }
}
