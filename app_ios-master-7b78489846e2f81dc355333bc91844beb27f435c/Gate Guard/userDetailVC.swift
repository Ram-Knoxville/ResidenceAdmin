//
//  userDetailVC.swift
//  Gate Guard
//
//  Created by Ram on 3/11/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class userDetailVC: UIViewController {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userLastNameField: UITextField!
    @IBOutlet weak var uerEmailField: UITextField!
    @IBOutlet weak var userPhoneField: UITextField!
    @IBOutlet weak var userMobilePhoneField: UITextField!
    @IBOutlet weak var saveBtnStyle: UIButton!
    @IBOutlet weak var userNavigationTitle: UINavigationItem!
    
    var user: Users!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.userNavigationTitle.title = user.firstNames
        self.userNameField.text = user.firstNames
        self.userLastNameField.text = user.lastNames
        self.uerEmailField.text = user.email
        self.userMobilePhoneField.text = user.phoneMobile
        
        self.saveBtnStyle.layer.cornerRadius = 5.0
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        // Alert
        let alert = UIAlertController(title: "Mensaje", message: "Usuario Guardado Exitosamente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)

    }
}
