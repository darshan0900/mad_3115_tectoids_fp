//
//  Tester.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Tester : Employee {
    static let GAIN_FACTOR_ERROR = 10
    
    private var _nbBugs : Int
    
    override var description: String{
        return "\(super.description) and corrected \(getNoOfBugs()) bugs.\nHis/Her estimated annual income is \(getAnnualIncome())"
    }
    
    init(
        name: String,
        birthYear: Int,
        nbBugs: Int,
        rate: Int = DEFAULT_OCCUPATION_RATE,
        employeeVehicle: Vehicle? = nil
    ) {
        self._nbBugs = nbBugs
        super.init(
            name: name,
            birthYear: birthYear,
            rate: rate,
            role: "Tester",
            employeeVehicle: employeeVehicle
        )
    }

    func getNoOfBugs() -> Int {
        return _nbBugs
    }
    
    func setNoOfBugs(nbBugs: Int) {
        self._nbBugs = nbBugs
    }
    
    override func getAnnualIncome() -> Float {
        let baseAnnualIncome = super.getAnnualIncome()
        let bugBonus = Float(getNoOfBugs() * Tester.GAIN_FACTOR_ERROR)
        
        let annualIncome = baseAnnualIncome + bugBonus
        
        return annualIncome
    }
}

