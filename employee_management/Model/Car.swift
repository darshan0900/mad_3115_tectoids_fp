//
//  Car.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Car: Vehicle {
    private var _gear: String
    private var _type: String
    
    override var description: String{
        return "Employee has a car. \n \(super.description)\n\t- gear type: \(getGear()) \n\t- type: \(getType())"
    }
    
    init(
        make _make: String,
        plate _plate: String,
        color _color: String,
        category _category: String,
        gear _gear: String,
        type _type: String
    ) {
        self._gear = _gear
        self._type = _type
        
        super.init(
            make: _make,
            plate: _plate,
            color: _color,
            category: _category
        )
    }
    
    func getGear() -> String {
        return _gear
    }
    
    func setGear(gear: String) {
        self._gear = gear
    }
    
    func getType() -> String {
        return _type
    }
    
    func setType(type: String) {
        self._type = type
    }
    
}
