//
//  Profiles.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Profiles {
    private var _name: String!
    
    var name: String {
        return _name
    }
    
    init(name: String) {
        self._name = name
    }
}
