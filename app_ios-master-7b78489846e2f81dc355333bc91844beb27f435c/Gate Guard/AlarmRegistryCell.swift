//
//  AlarmRegistryCell.swift
//  Gate Guard
//
//  Created by Ram on 4/19/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class AlarmRegistryCell: UITableViewCell {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var eventLbl: UILabel!
    
    var AlarmEvent: AlarmEvents!
    
    func configureCell(alarmEvent: AlarmEvents) {
        self.AlarmEvent = alarmEvent
        
        
        self.dateLbl.text = alarmEvent.date
        self.timeLbl.text = alarmEvent.time
        self.typeLbl.text = alarmEvent.type
        self.classLbl.text = alarmEvent.eventClass
        self.eventLbl.text = alarmEvent.eventName
        
        switch alarmEvent.ack {
        case "0":
            self.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case "1":
            self.backgroundColor = #colorLiteral(red: 0.1497283775, green: 1, blue: 0.4098269023, alpha: 0.6074753853)
        default:
            self.backgroundColor = #colorLiteral(red: 0.1497283775, green: 1, blue: 0.4098269023, alpha: 0.6074753853)
        }
    }
}
