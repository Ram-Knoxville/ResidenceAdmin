//
//  EventsFeedVC.swift
//  Gamalog
//
//  Created by Ram on 6/4/17.
//  Copyright © 2017 Rowan Technologies. All rights reserved.
//

import UIKit

class EventsFeedVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var eventsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventsCollection.delegate = self
        self.eventsCollection.dataSource = self
        
    }
    
    
    func dataParser() {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EventCell {
            return cell
        }else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:305, height:208)
    }

}

