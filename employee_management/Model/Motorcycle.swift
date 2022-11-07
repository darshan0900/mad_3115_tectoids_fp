//
//  Motorcycle.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Motorcycle: Vehicle {
    private var _sidecar: Bool
    
    override var description: String{
        var desc = "Employee has a motorcycle. \n \(super.description) \n\t- "
        if getSidecar(){
            desc+="with"
        }else{
            desc+="without"
        }
        desc+=" sidecar"
        return desc
    }
    
    init(
        make _make: String,
        plate _plate: String,
        color _color: String,
        category _category: String,
        sidecar _sidecar: Bool
    ) {
        self._sidecar = _sidecar
        
        super.init(
            make: _make,
            plate: _plate,
            color: _color,
            category: _category
        )
    }
    
    func getSidecar() -> Bool {
        return _sidecar
    }
    
    func setSidecar(sidecar: Bool) {
        self._sidecar = sidecar
    }
    
}
