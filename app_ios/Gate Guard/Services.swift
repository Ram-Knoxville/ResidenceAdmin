//
//  Services.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Services {
    private var _name:      String!
    private var _category:  String!
    
    var name: String {
        return _name
    }
    
    var category: String {
        return _category
    }
    
    init(name: String, category: String) {
        self._name      = name
        self._category  = category
    }
}
