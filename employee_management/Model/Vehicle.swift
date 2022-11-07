//
//  Vehicle.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Vehicle: CustomStringConvertible {
    private var _make : String
    private var _plate : String
    private var _color : String
    private var _category : String
    
    var description: String{
        return "\t- make: \(getMake()) \n\t- plate: \(getPlate()) \n\t- color: \(getColor()) \n\t- category: \(getCategory())"
    }
    
    init(
        make _make: String,
        plate _plate: String,
        color _color: String,
        category _category: String
    ) {
        self._make = _make
        self._plate = _plate
        self._color = _color
        self._category = _category
    }
    
    func getMake () -> String{
        return _make
    }
    
    func setMake (make: String) {
        self._make = make
    }
    
    func getPlate () -> String {
        return _plate
    }
    
    func setPlate (plate: String) {
        self._plate = plate
    }
    
    func getColor () -> String{
        return _color
    }
    
    func setColor (color: String) {
        self._color = color
    }
    
    func getCategory() -> String {
        return _category
    }
    
    func setCategory(category: String) {
        self._category = category
    }
}
