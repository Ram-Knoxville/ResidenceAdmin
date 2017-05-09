//
//  guardsListVC.swift
//  Gate Guard
//
//  Created by Ram on 3/7/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class guardsListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var guardsListCollection: UICollectionView!
    
    @IBOutlet weak var guardsSearchBar: UISearchBar!
    
    @IBOutlet weak var newGuardBtnStyle: UIButton!
    
    var guards = [Guards]()
    var filteredGuards = [Guards]()
    var inSearchMode = false
    
    var totalGuards = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.guardsListCollection.delegate = self
        self.guardsListCollection.dataSource = self
        self.guardsSearchBar.delegate = self
        
        self.guardsSearchBar.returnKeyType = UIReturnKeyType.done
        self.guardsSearchBar.keyboardAppearance = UIKeyboardAppearance.dark
        
        self.newGuardBtnStyle.layer.cornerRadius = 5.0
        
        let guard1 = ["name": "Roberto", "lastName": "Melendez", "profile": "Guardia", "block": "Casa Blanca", "email": "guardia1@gmail.com", "password": "123456", "imageUrl": "security.png"]
        
        let guard2 = ["name": "Carlos", "lastName": "Melendez", "profile": "Guardia", "block": "Casa Blanca", "email": "guardia1@gmail.com", "password": "123456", "imageUrl": "security.png"]
        
        let guard3 = ["name": "Sebastian", "lastName": "Melendez", "profile": "Guardia", "block": "Casa Blanca", "email": "guardia1@gmail.com", "password": "123456", "imageUrl": "security.png"]
        
        let guard4 = ["name": "Pedro", "lastName": "Melendez", "profile": "Guardia", "block": "Casa Blanca", "email": "guardia1@gmail.com", "password": "123456", "imageUrl": "security.png"]
        
        
        
        totalGuards.append(guard1)
        totalGuards.append(guard2)
        totalGuards.append(guard3)
        totalGuards.append(guard4)
        
        self.dataParser()
    }
    
    func dataParser() {
        let guardias = totalGuards
        for r in guardias{
            let name = r["name"]!
            let lastName = r["lastName"]!
            let profile = r["profile"]!
            let block = r["block"]!
            let email = r["email"]!
            let password = r["password"]!
            let imageUrl = r["imageUrl"]!
            
            let guardss = Guards(name: name, lastName: lastName, profile: profile, block: block, email: email, password: password, imageUrl: imageUrl)
            guards.append(guardss)
        }
    }
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? GuardsCell {
            
            let guardia: Guards!
            
            if inSearchMode {
                guardia = filteredGuards[indexPath.row]
                cell.configureCell(guardia: guardia)
            }else {
                guardia = guards[indexPath.row]
                cell.configureCell(guardia: guardia)
            }
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredGuards.count
        }else {
            return guards.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var guardia: Guards!
        
        if inSearchMode {
            guardia = filteredGuards[indexPath.row]
        }else{
            guardia = guards[indexPath.row]
        }
        
        performSegue(withIdentifier: "guardListToDetail", sender: guardia)
    }
    
    // MARK: - Search Bar Functions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if guardsSearchBar.text == nil || guardsSearchBar.text == "" {
            inSearchMode = false
            guardsListCollection.reloadData()
            view.endEditing(true)
        }else{
            inSearchMode = true
            
            filteredGuards = guards.filter({$0.name.range(of: self.guardsSearchBar.text!) != nil})
            guardsListCollection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "guardListToDetail" {
            if let guardDetailVC = segue.destination as? guardDetailVC {
                if let guardia = sender as? Guards {
                    guardDetailVC.guardia = guardia
                }
            }
        }
    }

}
