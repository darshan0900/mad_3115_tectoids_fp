//
//  Permanent.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Permanent: Contract {
    static let WORKING_DAYS = 20
    
    private var _nbChildren: Int
    private var _married: Bool
    private var _monthlySalary: Float
    private var _bonusPerChildPerMonth: Float
    private var _accumulatedDays: Int
    
    var description: String{
        return "he is \(getIsMarried() ? "" : "not ")married and he/she has \(getNoOfChildren()) children.\nHe/She has worked for \(getAccumulatedDays()) days and upon contract his/her monthly salary is \(getMonthlySalary())."
    }
    
    init(
        nbChildren _nbChildren: Int,
        married _married: Bool,
        monthlySalary _monthlySalary: Float,
        bonusPerChildPerMonth _bonusPerChildPerMonth: Float,
        accumulatedDays _accumulatedDays: Int
    ) {
        self._nbChildren = _nbChildren
        self._married = _married
        self._monthlySalary = _monthlySalary
        self._bonusPerChildPerMonth = _bonusPerChildPerMonth
        self._accumulatedDays = _accumulatedDays
    }
    
    func getNoOfChildren () -> Int{
        return _nbChildren
    }
    
    func setNoOfChildren (nbChildren: Int){
        self._nbChildren = nbChildren
    }
    
    func getIsMarried () -> Bool {
        return _married
    }

    func setIsMarried (married: Bool){
        self._married = married
    }
    
    func getMonthlySalary () -> Float {
        return _monthlySalary
    }

    func setMonthlySalary (monthlySalary: Float){
        self._monthlySalary = monthlySalary
    }
    
    func getBonusPerChildPerMonth () -> Float {
        return _bonusPerChildPerMonth
    }

    func setBonusPerChildPerMonth (bonusPerChildPerMonth: Float){
        self._bonusPerChildPerMonth = bonusPerChildPerMonth
    }
    
    func getAccumulatedDays () -> Int {
        return _accumulatedDays
    }

    func setAccumulatedDays (accumulatedDays: Int){
        self._accumulatedDays = accumulatedDays
    }
    
    func getCummulativeSalary () -> Float {
        var baseSalary = getMonthlySalary()
        if(getIsMarried()){
            // Adding child bonus if the employee is married
            baseSalary += (getBonusPerChildPerMonth() * Float(getNoOfChildren()))
        }
        return Float(getAccumulatedDays()) * baseSalary / Float(Permanent.WORKING_DAYS)
    }
    
}

