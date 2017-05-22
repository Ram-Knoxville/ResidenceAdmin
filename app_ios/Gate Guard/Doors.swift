//
//  Doors.swift
//  Gate Guard
//
//  Created by Ram on 5/22/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Doors {
    private var _doorType: String!
    private var _name: String!
    private var _pedestrian: String!
    private var _uid: String!
    
    
    var doorType: String {
        return _doorType
    }
    
    var name: String {
        return _name
    }
    
    var pedestrian: String {
        return _pedestrian
    }
    
    var uid: String {
        return _uid
    }
    
    init(doorType: String, name: String, pedestrian: String, uid: String){
        self._doorType = doorType
        self._name = name
        self._pedestrian = pedestrian
        self._uid = uid
    }
}
