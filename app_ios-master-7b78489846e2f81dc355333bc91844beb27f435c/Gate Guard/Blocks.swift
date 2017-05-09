//
//  Blocks.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Blocks {
    private var _name:              String!
    private var _residencesNumber:  String!
    private var _state:             String!
    private var _city:              String!
    private var _zipCode:           String!
    private var _logoUrl:           String!
    
    var name: String {
        return _name
    }
    
    var residencesNumber: String {
        return _residencesNumber
    }
    
    var state: String {
        return _state
    }
    
    var city: String {
        return _city
    }
    
    var zipCode: String {
        return _zipCode
    }
    
    var logoUrl: String {
        return _logoUrl
    }
    
    init(name: String, residencesNumber: String, state: String, city: String, zipCode: String, logoUrl: String) {
        self._name              = name
        self._residencesNumber  = residencesNumber
        self._state             = state
        self._city              = city
        self._zipCode           = zipCode
        self._logoUrl           = logoUrl
    }
    
}
