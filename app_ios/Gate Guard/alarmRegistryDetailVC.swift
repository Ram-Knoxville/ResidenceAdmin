//
//  alarmRegistryDetailVC.swift
//  Gate Guard
//
//  Created by Ram on 4/20/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class alarmRegistryDetailVC: UIViewController {

    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var TimeLbl: UILabel!
    @IBOutlet weak var TypeLbl: UILabel!
    
    var AlarmEvent: AlarmEvents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NameLbl.text = AlarmEvent.eventName
        self.DateLbl.text = AlarmEvent.date
        self.TimeLbl.text = AlarmEvent.time
        self.TypeLbl.text = AlarmEvent.type
    }
    
    @IBAction func dismisscontroller(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
}
