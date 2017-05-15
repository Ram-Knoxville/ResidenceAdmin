//
//  settingsVC.swift
//  Gate Guard
//
//  Created by Ram on 5/15/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit

class settingsVC: UIViewController {

    @IBOutlet weak var activateGateNotifications: UISwitch!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    var validator: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: "ValidadorPermisoEntrada") != nil {
           validator = true
        }else {
            validator = false
        }
        
        
        if validator{
            activateGateNotifications.isOn = true
            
        }else {
            activateGateNotifications.isOn = false
        }
        
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        
    }
    
    
    @IBAction func activateGateNotificationsAction(_ sender: Any) {
        
        if activateGateNotifications.isOn == true{
            activateGateNotifications.isOn = false
            print("Se apago esta madre alv")
            UserDefaults.standard.set(false, forKey: "ValidadorPermisoEntrada")
        }else {
            activateGateNotifications.isOn = true
            print("Se encendio esta madre alv")
            UserDefaults.standard.set(true, forKey: "ValidadorPermisoEntrada")
        }
        
    }
    

}
