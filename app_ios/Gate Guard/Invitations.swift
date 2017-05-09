//
//  Invitations.swift
//  Gate Guard
//
//  Created by Ram on 4/13/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Invitations {
    
    private var _invitationUid: String!
    private var _dateInvitationIni: String!
    private var _dateInvitationEnd: String!
    private var _confirmed: String!
    private var _plate: String!
    private var _guestName: String!
    
    var invitationUid: String {
        return _invitationUid
    }
    
    var dateInvitationIni: String {
        return _dateInvitationIni
    }
    
    var dateInvitationEnd: String {
        return _dateInvitationEnd
    }
    
    var confirmed: String {
        return _confirmed
    }
    
    var plate: String {
        return _plate
    }
    
    var guestName: String {
        return _guestName
    }
    
    init(invitationUid: String, dateInvitationIni: String, dateInvitationEnd: String, confirmed: String, plate: String, guestName: String){
        self._invitationUid = invitationUid
        self._dateInvitationIni = dateInvitationIni
        self._dateInvitationEnd = dateInvitationEnd
        self._confirmed = confirmed
        self._plate = plate
        self._guestName = guestName
    }
}
