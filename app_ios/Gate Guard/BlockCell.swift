//
//  BlockCell.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class BlockCell: UICollectionViewCell {
    @IBOutlet weak var blockImage: UIImageView!
    @IBOutlet weak var blockNameLbl: UILabel!
    
    var block: Blocks!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(block: Blocks){
        self.block = block
        
        blockImage.image = UIImage(named: "\(self.block.logoUrl)")
        blockNameLbl.text = "\(self.block.name)"
    }
    
    
}

/*

 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 
 layer.cornerRadius = 5.0
 }
 
 func configureCell(user: Users){
 self.user = user
 
 userImage.image = UIImage(named: "\(self.user.imageUrl)")
 userNameLbl.text = "\(self.user.name)"
 }
 
*/
