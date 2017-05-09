//
//  usersListVC.swift
//  Gate Guard
//
//  Created by Ram on 3/3/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import SwiftGifOrigin

class usersListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var usersListCollection: UICollectionView!
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    @IBOutlet weak var newUserBtnStyle: UIButton!
    
    @IBOutlet weak var activityIndicator: UIImageView!
    
    var sessionToken: String!
    var users = [Users]()
    var filteredUsers = [Users]()
    var inSearchMode = false
    
    var totalUser = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.loadGif(name: "loading")
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        self.usersListCollection.delegate = self
        self.usersListCollection.dataSource = self
        self.userSearchBar.delegate = self
        
        self.userSearchBar.returnKeyType = UIReturnKeyType.done
        self.userSearchBar.keyboardAppearance = UIKeyboardAppearance.dark
        
        self.newUserBtnStyle.layer.cornerRadius = 5.0
        
        
        
        
        
        

        let residenceUid = KeychainWrapper.standard.string(forKey: "ResidenceUid")!
        let token = KeychainWrapper.standard.string(forKey: "token")!
        
        self.getUsers(residenceUid: residenceUid, token: token)
        
        
        
    }
    
    func getUsers(residenceUid: String, token: String) {
        
        //Send request to server
        
        let urlString = "http://api.gateguard.com.mx/api/Users/getUsersMobile"
        
        let parameters: Parameters = [
            "residenceUid": residenceUid,
            "token": token
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON : \(JSON)")
                
                let result = response.result
                
                if let dict = result.value as? Dictionary<String, AnyObject>{
                    
                    if dict["status"] as? String != "OK"{
                        
                    }else if dict["status"] as? String  == "OK"{

                        for i in dict["data"]!["users"] as! [[String : Any]]{
                            
                            print(i.count)
                            self.totalUser.append(i)

                        }
                        print("ya la armaste we checa este pedo \(self.totalUser)")
                        self.dataParser()
                    }
                }
                
            }
        }
    }

    func dataParser() {
        
        let user = totalUser
//        print("Aqui hay un pedo checa que pasa \(user)")
        for r in user{
            
            let active: String! = r["active"]! as! String
            let dateMod: String! = r["dateMod"]! as! String
            let dateReg: String! = r["dateReg"]! as! String
            let deleted: String! = r["deleted"]! as! String
            let email: String! = r["email"]! as! String
            let facebookId: String! = "null"
            
            let firstNames: String! = r["firstNames"]! as! String
            let googleId: String! = "<null>"
            
            let id: String! = r["id"]! as! String
            let lastNames: String! = r["lastNames"]! as! String
            let password: String! = r["password"]! as! String
            let phoneMobile: String! = r["phoneMobile"]! as! String
            
            let photo: String!
            if r["photo"]! as? String == nil {
                photo = "avatar.png"
            }else {
                photo = r["photo"]! as! String
            }
            
            
//            let statusGps: String! = r["statusGps"]! as! String
//            let twitterID: String! = "null"
//            
//            let uid: String! = r["uid"]! as! String
//            let userModId: String! = r["userModId"]! as! String
//            let userRegId: String! = r["userRegId"]! as! String
            
            print(photo)
            let userss = Users(active: active, dateMod: dateMod, dateReg: dateReg, deleted: deleted, email: email, facebookId: facebookId, firstNames: firstNames, googleId: googleId, id: id, lastNames: lastNames, password: password, phoneMobile: phoneMobile, photo: photo)
            users.append(userss)
            
            usersListCollection.reloadData()
            
            self.activityIndicator.isHidden = true
            
        }
    }
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? UserCell {
            
            let user: Users!
            
            if inSearchMode {
                user = filteredUsers[indexPath.row]
                cell.configureCell(user: user)
            }else {
                user = users[indexPath.row]
                cell.configureCell(user: user)
            }
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredUsers.count
        }else{
            return users.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var user: Users!
        
        if inSearchMode {
            user = filteredUsers[indexPath.row]
        }else {
            user = users[indexPath.row]
        }
        
        performSegue(withIdentifier: "userListToDetail", sender: user)
    }
    
    // MARK: - search Bar Functions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if userSearchBar.text == nil || userSearchBar.text == "" {
            inSearchMode = false
            usersListCollection.reloadData()
            view.endEditing(true)
        }else {
            inSearchMode = true
            
            filteredUsers = users.filter({$0.firstNames.range(of: self.userSearchBar.text!) != nil })
            usersListCollection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userListToDetail" {
            if let userDetailVC = segue.destination as? userDetailVC {
                if let user = sender as? Users {
                    userDetailVC.user = user
                }
            }
        }
    }

}
