//
//  Guests.swift
//  Gate Guard
//
//  Created by Ram on 4/10/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Guests {
    private var _firstNames: String!
    private var _lastNames: String!
    private var _email: String!
    private var _id: String!
    private var _phone: String!
    private var _guestUid: String!
    
    var guestUid: String {
        return _guestUid
    }
    
    var firstNames: String {
        return _firstNames
    }
    
    var lastNames: String {
        return _lastNames
    }
    
    var email: String {
        return _email
    }
    
    var id: String {
        return _id
    }
    
    var phone: String {
        return _phone
    }
    
    
    init(firstNames: String, lastNames: String, email: String, id: String, phone: String, guestUid: String) {
        self._firstNames = firstNames
        self._lastNames = lastNames
        self._email = email
        self._id = id
        self._phone = phone
        self._guestUid = guestUid
    }
}
