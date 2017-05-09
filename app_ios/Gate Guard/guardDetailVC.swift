//
//  guardDetailVC.swift
//  Gate Guard
//
//  Created by Ram on 3/11/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class guardDetailVC: UIViewController {

    @IBOutlet weak var guardPicture: UIImageView!
    
    @IBOutlet weak var guardNameField: UITextField!
    
    @IBOutlet weak var guardLastNameField: UITextField!
    
    @IBOutlet weak var guardProfileField: UITextField!
    
    @IBOutlet weak var guardBlockField: UITextField!
    
    @IBOutlet weak var guardEmailField: UITextField!
    
    @IBOutlet weak var guardPasswordField: UITextField!
    
    @IBOutlet weak var saveBtnStyle: UIButton!
    
    @IBOutlet weak var guardNavigationTitle: UINavigationItem!
    
    var guardia: Guards!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = guardia.name
        self.guardNameField.text = guardia.name
        self.guardLastNameField.text = guardia.lastName
        self.guardBlockField.text = guardia.block
        self.guardEmailField.text = guardia.email
        self.guardPasswordField.text = guardia.password
        self.guardNavigationTitle.title = guardia.name
        self.saveBtnStyle.layer.cornerRadius = 5.0
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        
        // Alert
        let alert = UIAlertController(title: "Mensaje", message: "Guardia Guardado Exitosamente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }

}
