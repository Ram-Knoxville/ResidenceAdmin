//
//  UserCell.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    var user: Users!
    
    var picture: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(user: Users){
        self.user = user
        
        if self.user.photo == "avatar.png" {
            userImage.image = UIImage(named: "avatar.png")
        }else {
            
            picture = self.user.photo
            
            let url = NSURL(string: "http://api.gateguard.com.mx/uploads/accounts/\(picture!)")!
            if let data = NSData(contentsOf: url as URL) {
                userImage.image = UIImage(data: data as Data)
            }
        }
        
        userImage.layer.cornerRadius = 100
        userNameLbl.text = "\(self.user.firstNames)"
    }
}
