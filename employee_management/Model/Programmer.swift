//
//  Programmer.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Programmer : Employee {
    static let GAIN_FACTOR_PROJECTS = 200
    
    private var _nbProjects : Int
    
    override var description: String{
        return "\(super.description) and completed \(getNoOfProjects()) projects.\nHis/Her estimated annual income is \(getAnnualIncome())"
    }
    
    init(
        name: String,
        birthYear: Int,
        nbProjects: Int = 0,
        rate: Int = DEFAULT_OCCUPATION_RATE,
        employeeVehicle: Vehicle? = nil
    ) {
        self._nbProjects = nbProjects
        super.init(
            name: name,
            birthYear: birthYear,
            rate: rate,
            role: "Programmer",
            employeeVehicle: employeeVehicle
        )
    }

    func getNoOfProjects() -> Int {
        return _nbProjects
    }
    
    func setNoOfProjects(nbProjects: Int) {
        self._nbProjects = nbProjects
    }
    
    override func getAnnualIncome() -> Float {
        let baseAnnualIncome = super.getAnnualIncome()
        let projectBonus = Float(getNoOfProjects() * Programmer.GAIN_FACTOR_PROJECTS)
        
        let annualIncome = baseAnnualIncome + projectBonus
        
        return annualIncome
    }
}