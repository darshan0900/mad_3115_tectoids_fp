//
//  Temporary.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Temporary: Contract {
    private var _hourlySalary: Float
    private var _accumulatedHours: Int
    
    var description: String{
        return "he is a temporary employee with \(getHourlySalary()) hourly salary and he has worked for \(getAccumulatedHours()) hours"
    }
    
    init(
        hourlySalary _hourlySalary: Float,
        accumulatedHours _accumulatedHours: Int
    ) {
        self._hourlySalary = _hourlySalary
        self._accumulatedHours = _accumulatedHours
    }
    
    func getHourlySalary () -> Float {
        return _hourlySalary
    }
    
    func setHourlySalary (hourlySalary: Float){
        self._hourlySalary = hourlySalary
    }
    
    func getAccumulatedHours () -> Int {
        return _accumulatedHours
    }
    
    func setAccumulatedHours (accumulatedHours: Int){
        self._accumulatedHours = accumulatedHours
    }
    
    func getCummulativeSalary () -> Float {
        return _hourlySalary * Float(_accumulatedHours)
    }
    
}

