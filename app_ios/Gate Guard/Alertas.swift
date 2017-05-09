//
//  Alertas.swift
//  Gate Guard
//
//  Created by Ram on 5/2/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class Alertas: UIAlertController {
    
    func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }

}
