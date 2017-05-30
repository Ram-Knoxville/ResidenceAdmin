//
//  ResidenceAccessLogCell.swift
//  Gate Guard
//
//  Created by Ram on 5/29/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class ResidenceAccessLogCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var accessLog: residenceAccessLog!
    
    func configureCell(accessLog: residenceAccessLog){
        self.accessLog = accessLog
        
        name.text = accessLog.name
        date.text = accessLog.date
        
    }

}
