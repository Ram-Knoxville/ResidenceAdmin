//
//  GuardsCell.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class GuardsCell: UICollectionViewCell {
    
    @IBOutlet weak var guardImage: UIImageView!
    @IBOutlet weak var guardNameLbl: UILabel!
    
    var guardia: Guards!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(guardia: Guards){
        self.guardia = guardia
        
        guardImage.image = UIImage(named: "\(self.guardia.imageUrl)")
        guardNameLbl.text = "\(self.guardia.name)"
    }
}
