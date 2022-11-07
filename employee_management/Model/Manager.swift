//
//  Manager.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Manager : Employee {
    static let GAIN_FACTOR_CLIENT = 500
    static let GAIN_FACTOR_TRAVEL = 100
    
    private var _nbTravelDays : Int
    private var _nbClients : Int
    
    override var description: String{
        return "\(super.description) He/She travelled \(getNoOfTravelDays()) days and has brought \(getNoOfClients()) new clients.\nHis/Her estimated annual income is \(getAnnualIncome())"
    }
    
    init(
        name: String,
        birthYear: Int,
        nbClients: Int,
        nbTravelDays: Int,
        rate: Int = DEFAULT_OCCUPATION_RATE,
        employeeVehicle: Vehicle? = nil
    ) {
        self._nbTravelDays = nbTravelDays
        self._nbClients = nbClients
        super.init(
            name: name,
            birthYear: birthYear,
            rate: rate,
            role: "Manager",
            employeeVehicle: employeeVehicle
        )
    }
    
    func getNoOfTravelDays() -> Int {
        return _nbTravelDays
    }
    
    func setNoOfTravelDays(nbTravelDays: Int) {
        self._nbTravelDays = nbTravelDays
    }
    
    func getNoOfClients() -> Int {
        return _nbClients
    }
    
    func setNoOfClients(nbClients: Int) {
        self._nbClients = nbClients
    }
    
    override func getAnnualIncome() -> Float {
        let baseAnnualIncome = super.getAnnualIncome()
        let clientBonus = Float(getNoOfClients() * Manager.GAIN_FACTOR_CLIENT)
        let travelExpense = Float(getNoOfTravelDays() * Manager.GAIN_FACTOR_TRAVEL)
        
        let annualIncome = baseAnnualIncome + clientBonus + travelExpense
        
        return annualIncome
    }
}
