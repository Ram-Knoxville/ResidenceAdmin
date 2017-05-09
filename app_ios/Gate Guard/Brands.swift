//
//  Brands.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Brands {
    private var _name:      String!
    private var _logoUrl:   String!
    
    var name: String {
        return _name
    }
    
    var logoUrl: String {
        return _logoUrl
    }
    
    init(name: String, logoUrl: String) {
        self._name      = name
        self._logoUrl   = logoUrl
    }
}
