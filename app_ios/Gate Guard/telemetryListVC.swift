//
//  telemetryListVC.swift
//  Gate Guard
//
//  Created by Ram on 3/8/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class telemetryListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var roomsList: UICollectionView!
    
    @IBOutlet weak var telemetrySearchBar: UISearchBar!
    
    
    var rooms = [Rooms]()
    var filteredRooms = [Rooms]()
    var inSearchMode = false
    
    var totalesSala = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        self.roomsList.delegate = self
        self.roomsList.dataSource = self
        self.telemetrySearchBar.delegate = self
        
        self.telemetrySearchBar.returnKeyType = UIReturnKeyType.done
        self.telemetrySearchBar.keyboardAppearance = UIKeyboardAppearance.dark
        
        let sala1 = ["name": "Estancia", "image": "tv", "temperature": "18ºC", "humidity": "18mPH", "pressure": "20"]
        let sala2 = ["name": "Sala", "image": "couch", "temperature": "20ºC", "humidity": "15mPH", "pressure": "18"]
        let sala3 = ["name": "Habitación", "image": "bed", "temperature": "21ºC", "humidity": "15mPH", "pressure": "18"]
        
        totalesSala.append(sala1)
        totalesSala.append(sala2)
        totalesSala.append(sala3)
        
        
        self.dataParser()
    }
    
    func dataParser() {
        
        let room = totalesSala
        for r in room{
            
            let name = r["name"]!
            let image = r["image"]!
            let temperature = r["temperature"]!
            let humidity = r["humidity"]!
            let pressure = r["pressure"]!
        
            let room = Rooms(name: name, image: image, temperature: temperature, humidity: humidity, pressure: pressure)
            rooms.append(room)
        }
    }
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RoomCell {
            
            let room: Rooms!
            
            if inSearchMode {
                
                room = filteredRooms[indexPath.row]
                cell.configureCell(room: room)
                
            }else {
                
                room = rooms[indexPath.row]
                cell.configureCell(room: room)
                
            }
            
            
            return cell
            
        }else{
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var room: Rooms!
        
        if inSearchMode {
            room = filteredRooms[indexPath.row]
        }else{
            room = rooms[indexPath.row]
        }
        performSegue(withIdentifier: "roomDetailSegue", sender: room)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredRooms.count
        }else{
            return rooms.count
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
        if telemetrySearchBar.text == nil || telemetrySearchBar.text == "" {
            inSearchMode = false
            roomsList.reloadData()
            view.endEditing(true)
            
        }else {
            inSearchMode = true
            
            filteredRooms = rooms.filter({$0.name.range(of: self.telemetrySearchBar.text!) != nil})
            roomsList.reloadData()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "roomDetailSegue" {
            if let detailVC = segue.destination as? telemetryVC {
                if let room = sender as? Rooms {
                    detailVC.room = room
                }
            }
        }
    }
    


}
