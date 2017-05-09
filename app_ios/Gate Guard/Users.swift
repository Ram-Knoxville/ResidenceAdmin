//
//  Users.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Users {
    private var _active: String!
    private var _dateMod: String!
    private var _dateReg: String!
    private var _deleted: String!
    private var _email: String!
    private var _facebookId: String!
    private var _firstNames: String!
    private var _googleId: String!
    private var _id: String!
    private var _lastNames: String!
    private var _password: String!
    private var _phoneMobile: String!
    private var _photo: String!

    
    var active: String {
        return _active
    }
    
    var dateMod: String {
        return _dateMod
    }
    
    var dateReg: String {
        return _dateReg
    }
    
    var deleted: String {
        return _deleted
    }
    
    var email: String {
        return _email
    }
    
    var facebookId: String {
        return _facebookId
    }
    
    var firstNames: String {
        return _firstNames
    }
    
    var googleId: String {
        return _googleId
    }
    
    var id: String {
        return _id
    }
    
    var lastNames: String {
        return _lastNames
    }
    
    var password: String {
        return _password
    }
    
    var phoneMobile: String {
        return _phoneMobile
    }
    
    var photo: String {
        return _photo
    }
    
    init(active: String, dateMod: String, dateReg: String, deleted: String, email: String, facebookId: String, firstNames: String, googleId: String, id: String, lastNames: String, password: String, phoneMobile: String, photo: String){
        
        self._active = active
        self._dateMod = dateMod
        self._dateReg = dateReg
        self._deleted = deleted
        self._email = email
        self._facebookId = facebookId
        self._firstNames = firstNames
        self._googleId = googleId
        self._id = id
        self._lastNames = lastNames
        self._password = password
        self._phoneMobile = phoneMobile
        self._photo = photo
        
    }
    
}
