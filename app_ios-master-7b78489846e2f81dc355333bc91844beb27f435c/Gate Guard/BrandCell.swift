//
//  BrandCell.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class BrandCell: UICollectionViewCell {
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var brandNameLbl: UILabel!
    
    var brand: Brands!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(brand: Brands){
        brandImage.image = UIImage(named: "\(self.brand.logoUrl)")
        brandNameLbl.text = "\(self.brand.name)"
    }
}
