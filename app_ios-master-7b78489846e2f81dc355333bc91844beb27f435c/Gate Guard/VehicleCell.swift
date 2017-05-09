//
//  VehicleCell.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class VehicleCell: UICollectionViewCell {
    
    @IBOutlet weak var VehicleBrandLogo: UIImageView!
    @IBOutlet weak var VehicleModelLbl: UILabel!
    @IBOutlet weak var VehiclePlateLbl: UILabel!
    
    var vehicle: Vehicles!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(vehicle: Vehicles) {
        
        self.vehicle = vehicle
        
        let url = NSURL(string: "http://api.gateguard.com.mx/uploads/brands/\(self.vehicle.logo)")!
        if let data = NSData(contentsOf: url as URL) {
            VehicleBrandLogo.image = UIImage(data: data as Data)
        }
        
        VehicleModelLbl.text = "\(self.vehicle.brandName)"
        VehiclePlateLbl.text = "\(self.vehicle.plate)"
    }
}
