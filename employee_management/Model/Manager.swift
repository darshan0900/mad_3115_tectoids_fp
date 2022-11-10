//
//  Manager.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

struct Manager : Employee {
	
	static let GAIN_FACTOR_CLIENT = 500
	static let GAIN_FACTOR_TRAVEL = 100
	
	internal var empId: String
	internal var name: String
	internal var dob: Date
	internal var monthlySalary: Float
	internal var rate: Float
	internal var role: String
	internal var employeeVehicle: Vehicle?
	
	private var nbClients : Int
	
	var description: String{
		return "\((self as Employee).getDescription()) He/She has brought \(getNoOfClients()) new clients.\nHis/Her estimated annual income is $\(getAnnualIncome())"
	}
	
	init(
		empId: String,
		name: String,
		dob: Date,
		nbClients: Int,
		monthlySalary: Float,
		rate: Float = DEFAULT_OCCUPATION_RATE,
		employeeVehicle: Vehicle? = nil
	) {
		self.empId = empId
		self.name = name
		self.dob = dob
		self.monthlySalary = monthlySalary
		// Validating occupation rate as per the given scenarios
		self.rate = validateOccupationRate(rate)
		self.role = "Manager"
		self.employeeVehicle = employeeVehicle
		self.nbClients = nbClients
		print("We have a new Employee: \(getName()), a \(getRole().lowercased())")
	}
	
	func getNoOfClients() -> Int {
		return nbClients
	}
	
	mutating func setNoOfClients(nbClients: Int) {
		self.nbClients = nbClients
	}
	
	func getAnnualIncome() -> Float {
		let baseAnnualIncome = (self as Employee).getAnnualIncome()
		let clientBonus = Float(getNoOfClients() * Manager.GAIN_FACTOR_CLIENT)
		
		let annualIncome = baseAnnualIncome + clientBonus
		
		return annualIncome
	}
}
