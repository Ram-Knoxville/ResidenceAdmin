//
//  telemetryVC.swift
//  Gate Guard
//
//  Created by Ram on 3/8/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class telemetryVC: UIViewController {
    
    @IBOutlet weak var temperatureLbl: UILabel!
    
    @IBOutlet weak var pressureLbl: UILabel!
    
    @IBOutlet weak var humidityLbl: UILabel!
    
    var room: Rooms!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.temperatureLbl.text = room.temperature
        
        self.pressureLbl.text = room.pressure
        
        self.humidityLbl.text = room.humidity
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "detailRoomToRoomLists", sender: nil)
        
    }

}
