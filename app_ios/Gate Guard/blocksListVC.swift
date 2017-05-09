//
//  blocksListVC.swift
//  Gate Guard
//
//  Created by Ram on 3/7/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class blocksListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var blockListCollection: UICollectionView!
    
    @IBOutlet weak var blocksSearchBar: UISearchBar!
    
    @IBOutlet weak var newBlockBtnStyle: UIButton!
    
    
    var blocks = [Blocks]()
    var filteredBlocks = [Blocks]()
    var inSearchMode = false
    
    var totalBlocks = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.blockListCollection.delegate = self
        self.blockListCollection.dataSource = self
        self.blocksSearchBar.delegate = self
        
        self.blocksSearchBar.keyboardAppearance = UIKeyboardAppearance.dark
        self.blocksSearchBar.returnKeyType = UIReturnKeyType.done
        
        self.newBlockBtnStyle.layer.cornerRadius = 5.0
        
        let block1 = ["name": "Casa Blanca", "residencesNumber": "28", "state": "Nuevo Leon", "city": "Apodaca", "zipCode": "66635", "logoUrl": "gateguard_LOGO-1"]
        
        let block2 = ["name": "Fresnos", "residencesNumber": "28", "state": "Nuevo Leon", "city": "Apodaca", "zipCode": "66635", "logoUrl": "gateguard_LOGO-1"]
        
        let block3 = ["name": "Ebanos", "residencesNumber": "28", "state": "Nuevo Leon", "city": "Apodaca", "zipCode": "66635", "logoUrl": "gateguard_LOGO-1"]
        
        let block4 = ["name": "Fome 4", "residencesNumber": "28", "state": "Nuevo Leon", "city": "Apodaca", "zipCode": "66635", "logoUrl": "gateguard_LOGO-1"]
        
        let block5 = ["name": "Robles", "residencesNumber": "28", "state": "Nuevo Leon", "city": "Apodaca", "zipCode": "66635", "logoUrl": "gateguard_LOGO-1"]
        
        let block6 = ["name": "Unidad Modelo", "residencesNumber": "28", "state": "Nuevo Leon", "city": "Apodaca", "zipCode": "66635", "logoUrl": "gateguard_LOGO-1"]
        
        totalBlocks.append(block1)
        totalBlocks.append(block2)
        totalBlocks.append(block3)
        totalBlocks.append(block4)
        totalBlocks.append(block5)
        totalBlocks.append(block6)
        
        self.dataParser()
    }
    
    func dataParser() {
        
        let block = totalBlocks
        for r in block{
            
            let name = r["name"]!
            let residencesNumber = r["residencesNumber"]!
            let state = r["state"]!
            let city = r["city"]!
            let zipCode = r["zipCode"]!
            let logoUrl = r["logoUrl"]!
            
            let blockss = Blocks(name: name, residencesNumber: residencesNumber, state: state, city: city, zipCode: zipCode, logoUrl: logoUrl)
            
            blocks.append(blockss)
        }
    }

    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BlockCell {
            let block: Blocks!
            
            if inSearchMode {
                block = filteredBlocks[indexPath.row]
                cell.configureCell(block: block)
            }else {
                block = blocks[indexPath.row]
                cell.configureCell(block: block)
            }
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredBlocks.count
        }else {
            return blocks.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var block: Blocks!
        
        if inSearchMode {
            block = filteredBlocks[indexPath.row]
        }else {
            block = blocks[indexPath.row]
        }
        
        performSegue(withIdentifier: "blockListToDetail", sender: block)
    }
    
    // Mark: - Search Bar Functions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if blocksSearchBar.text == nil || blocksSearchBar.text == "" {
            inSearchMode = false
            blockListCollection.reloadData()
            view.endEditing(true)
        }else {
            inSearchMode = true
            
            filteredBlocks = blocks.filter({$0.name.range(of: self.blocksSearchBar.text!) != nil})
            blockListCollection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "blockListToDetail" {
            if let blockDetailVC = segue.destination as? blockDetailVC {
                if let block = sender as? Blocks {
                    blockDetailVC.block = block
                }
            }
        }
    }

}
