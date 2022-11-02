//
//  Employee.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

private func validateOccupationRate (_ rate: Int) -> Int {
    if rate < 10 {
        return 10
    }
    else if rate > 100 {
        return 100
    }
    else {
        return rate
    }
}

class Employee: CustomStringConvertible {
    
    static let DEFAULT_OCCUPATION_RATE = 100
    
    private let _name : String
    private var _birthYear : Int
    private var _monthlyIncome: Float {
        var monthlyIncome:Float = 0.0
        // To check if it is not nil, and if it is not store in local variable contract
        if let contract = contract {
            // Since we have a common protocol Contract for both Permanent and Temporary contract with  function named getCummulativeSalary, we don't need to type cast object to its respective class.
            // Get cummulative salary according to the contract
            monthlyIncome = contract.getCummulativeSalary()
        }
        // Recalculating base monthly income according to the occupation rate
        monthlyIncome *= Float(getOccupationRate())/100.0
        return monthlyIncome
    }
    private var _rate : Int
    private var _role : String
    private var _employeeVehicle: Vehicle?
    var contract: Contract?
    
    var description: String{
        var desc = "Name: \(getName()), a \(getRole()) \nAge: \(getAge())\n"
        if let vehicle = _employeeVehicle{
            desc += vehicle.description
        }
        desc += "\n\(getName()) has an Occupation rate: \(getOccupationRate())%"
        return desc
    }
    
    init(
        name _name: String,
        birthYear _birthYear: Int,
        rate _rate: Int = DEFAULT_OCCUPATION_RATE,
        role _role : String,
        employeeVehicle _employeeVehicle: Vehicle?
    ) {
        self._name = _name
        self._birthYear = _birthYear
        // Validating occupation rate as per the given scenarios
        self._rate = validateOccupationRate(_rate)
        self._role = _role
        self._employeeVehicle = _employeeVehicle
        print("We have a new Employee: \(getName()), a \(getRole().lowercased())")
    }
    
    func getName() -> String {
        return _name
    }
    
    func getYearOfBirth() -> Int {
        return _birthYear
    }
    
    func setYearOfBirth(birthYear: Int) {
        self._birthYear = birthYear
    }
    
    func getAnnualIncome() -> Float {
        return Float(_monthlyIncome * 12)
    }
    
    func getOccupationRate() -> Int {
        return _rate
    }
    
    func setOccupationRate(rate: Int) {
        self._rate = validateOccupationRate(rate)
    }
    
    func getRole() -> String {
        return _role
    }
    
    func setRole(role: String) {
        self._role = role
    }
    
    func getAge() -> Int {
        let currentYear = Calendar.current.component(.year, from: Date())
        let age = currentYear - getYearOfBirth()
        return age
    }
    
    func getEmployeeVehicle () -> Vehicle? {
        return _employeeVehicle
    }
    
    func setEmployeeVehicle (employeeVehicle: Vehicle) {
        self._employeeVehicle = employeeVehicle
    }
    
    func signContract (contract: Contract){
        self.contract = contract
    }
    
    func contractInfo () -> String{
        return "\(getName()) is a \(getRole().lowercased())"
    }
    
}
