//
//  RoomCell.swift
//  Gate Guard
//
//  Created by Ram on 3/8/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class RoomCell: UICollectionViewCell {
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var roomNameLbl: UILabel!
    @IBOutlet weak var roomTemperature: UILabel!
    
    var room: Rooms!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(room: Rooms){
         self.room = room
        
        roomImage.image = UIImage(named: "\(self.room.image)")
        roomNameLbl.text = "\(self.room.name)"
        roomTemperature.text = "\(self.room.temperature)"
    }
}
