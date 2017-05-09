//
//  blockDetailVC.swift
//  Gate Guard
//
//  Created by Ram on 3/11/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class blockDetailVC: UIViewController {

    @IBOutlet weak var blockNavigationTitle: UINavigationItem!
   
    @IBOutlet weak var blockImageLogo: UIImageView!
    
    @IBOutlet weak var blockNamefield: UITextField!
    
    @IBOutlet weak var blockResidencyNumberField: UITextField!
    
    @IBOutlet weak var blockStateField: UITextField!
    
    @IBOutlet weak var blockCityField: UITextField!
    
    @IBOutlet weak var blockZipCodeField: UITextField!
    
    @IBOutlet weak var saveBtnStyle: UIButton!
    
    var block: Blocks!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.blockNavigationTitle.title = block.name
        self.blockImageLogo.image = UIImage(named: "\(block.logoUrl)")
        self.blockNamefield.text = block.name
        self.blockResidencyNumberField.text = block.residencesNumber
        self.blockStateField.text = block.state
        self.blockCityField.text = block.city
        self.blockZipCodeField.text = block.zipCode
        self.saveBtnStyle.layer.cornerRadius = 5.0
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        
        // Alert
        let alert = UIAlertController(title: "Mensaje", message: "Colonia Guardada Exitosamente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }

}
