//
//  Vehicles.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Vehicles {
    private var _accessGranted: String!
    private var _brandId: String!
    private var _brandName: String!
    private var _color: String!
    private var _id: String!
    private var _logo: String!
    private var _model: String!
    private var _plate: String!
    private var _relationUid: String!
    private var _statusGps: String!
    private var _uid: String!
    
    var accessGranted: String {
        return _accessGranted
    }
    
    var brandId: String {
        return _brandId
    }
    
    var brandName: String {
        return _brandName
    }
    
    var color: String {
        return _color
    }
    
    var id: String {
        return _id
    }
    
    var logo: String {
        return _logo
    }
    
    var model: String {
        return _model
    }

    var plate: String {
        return _plate
    }
    
    var relationUid: String {
        return _relationUid
    }
    
    var statusGps: String {
        return _statusGps
    }
    
    var uid: String {
        return _uid
    }
    
    init(accessGranted: String, brandId: String, brandName: String, color: String, id: String, logo: String, model: String, plate: String, relationUid: String, statusGps: String, uid: String)
    {
        self._accessGranted = accessGranted
        self._brandId = brandId
        self._brandName = brandName
        self._color = color
        self._id = id
        self._logo = logo
        self._model = model
        self._plate = plate
        self._relationUid = relationUid
        self._statusGps = statusGps
        self._uid = uid
    }
    
}
