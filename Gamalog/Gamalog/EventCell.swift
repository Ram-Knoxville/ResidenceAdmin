//
//  EventCell.swift
//  Gamalog
//
//  Created by Ram on 6/5/17.
//  Copyright © 2017 Rowan Technologies. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventName: UILabel!
    
    var Event: Events!
    
    func configureCell(event: Events) {
        self.Event = event
        
        eventImage.image = UIImage(named: Event.eventImage)
        eventDate.text = Event.eventDate
        eventName.text = Event.eventName
    }
    
    
}
