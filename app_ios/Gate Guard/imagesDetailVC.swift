//
//  imagesDetailVC.swift
//  Gate Guard
//
//  Created by Ram on 6/24/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class imagesDetailVC: UIViewController {

    
    var Requests: AccessRequest!
    
    @IBOutlet weak var platesImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let stringUrl = Requests.plateImg as? String{
            
            let placa: String! = "http://api.gateguard.com.mx/uploads/vehicles/cam_1/" + stringUrl
            let url = NSURL(string: placa)!
            if let data = NSData(contentsOf: url as URL){
                
                self.platesImageView.image = UIImage(data: data as Data)
                
            }
        }else {
            print("Aqui esta el error")
        }
    
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
