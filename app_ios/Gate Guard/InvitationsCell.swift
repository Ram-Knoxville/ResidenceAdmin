//
//  InvitationsCell.swift
//  Gate Guard
//
//  Created by Ram on 4/13/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class InvitationsCell: UICollectionViewCell {
    
    @IBOutlet weak var GuestNameLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var invitationDateLbl: UILabel!
    @IBOutlet weak var invitationDateToLbl: UILabel!
    @IBOutlet weak var plateLbl: UILabel!
    
    var invitation: Invitations!
    
    func configureCell(invitation: Invitations) {
        self.invitation = invitation
        
        self.editBtn.layer.borderColor = UIColor.white.cgColor
        self.resendBtn.layer.borderColor = UIColor.white.cgColor
        self.cancelBtn.layer.borderColor = UIColor.white.cgColor
        
        self.invitationDateLbl.text = "De: \(invitation.dateInvitationIni)"
        self.invitationDateToLbl.text = "A: \(invitation.dateInvitationEnd)"
        self.plateLbl.text = invitation.plate
        
        self.plateLbl.layer.borderWidth = 1
        self.plateLbl.layer.borderColor = UIColor.white.cgColor
        
        switch invitation.confirmed {
        case "0":
            self.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            self.cancelBtn.isHidden = false
            self.editBtn.isHidden = false
            self.resendBtn.isHidden = false
            self.GuestNameLbl.text = "\(invitation.guestName) (Pendiente)"
        case "1":
            self.backgroundColor = #colorLiteral(red: 0.1497283775, green: 1, blue: 0.4098269023, alpha: 0.6074753853)
            self.cancelBtn.isHidden = false
            self.editBtn.isHidden = false
            self.resendBtn.isHidden = true
            self.GuestNameLbl.text = "\(invitation.guestName) (Confirmada)"
        case "2":
            self.backgroundColor = #colorLiteral(red: 0.7820233185, green: 0.3065785842, blue: 0.1877702123, alpha: 1)
            self.cancelBtn.isHidden = true
            self.editBtn.isHidden = true
            self.resendBtn.isHidden = true
            self.GuestNameLbl.text = "\(invitation.guestName) (Cancelada)"
        default:
            self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
    
        let token: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")!
        let id: String! = invitation.invitationUid
        
        let urlString = "http://api.gateguard.com.mx/api/myGuests/cancelInvitation"
        
        let parameters: Parameters = [
            "token": token,
            "invitationId": id
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON : \(JSON)")
                
            }
        }
    }
    
    @IBAction func resendBtnPressed(_ sender: Any) {
        let token: String! = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")!
        let id: String! = invitation.invitationUid
        
        let urlString = "http://api.gateguard.com.mx/api/myGuests/forwardSendInvitation"
        
        let parameters: Parameters = [
            "token": token,
            "invitationId": id
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON : \(JSON)")
                
            }
        }
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        
        UserDefaults.standard.setValue(invitation.invitationUid, forKey: "invitationId")
        
    }
    
}
