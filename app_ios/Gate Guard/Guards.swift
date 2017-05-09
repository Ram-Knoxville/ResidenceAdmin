//
//  Guards.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Guards {
    private var _name:      String!
    private var _lastName:  String!
    private var _profile:   String!
    private var _block:     String!
    private var _email:     String!
    private var _password:  String!
    private var _imageUrl:  String!
    
    var name: String {
        return _name
    }
    
    var lastName: String {
        return _lastName
    }
    
    var profile: String {
        return _profile
    }
    
    var block: String {
        return _block
    }
    
    var email: String {
        return _email
    }
    
    var password: String {
        return _password
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    init(name: String, lastName: String, profile: String, block: String, email: String, password: String, imageUrl: String) {
        self._name      = name
        self._lastName  = lastName
        self._profile   = profile
        self._block     = block
        self._email     = email
        self._password  = password
        self._imageUrl  = imageUrl
    }
}
