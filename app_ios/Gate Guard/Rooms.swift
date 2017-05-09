//
//  Rooms.swift
//  Gate Guard
//
//  Created by Ram on 3/8/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class Rooms {
    private var _name: String!
    private var _image: String!
    private var _temperature: String!
    private var _humidity: String!
    private var _pressure: String!
    
    var name: String {
        return _name
    }
    
    var image : String {
        return _image
    }
    
    var temperature: String {
        return _temperature
    }
    
    var humidity: String {
        return _humidity
    }
    
    var pressure: String {
        return _pressure
    }
    
    init(name: String, image: String, temperature: String, humidity: String, pressure: String) {
        self._name = name
        self._image = image
        self._temperature = temperature
        self._humidity = humidity
        self._pressure = pressure
    }
}
