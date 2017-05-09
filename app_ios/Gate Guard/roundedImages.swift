//
//  roundedImages.swift
//  Gate Guard
//
//  Created by Ram on 2/23/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation
import UIKit

class roundedImages: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let SHADOW_GRAY: CGFloat = 120.0 / 255.0
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
