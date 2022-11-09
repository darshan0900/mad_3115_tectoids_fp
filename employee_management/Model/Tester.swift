//
//  Tester.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

struct Tester : Employee {
	
	static let GAIN_FACTOR_ERROR = 10
	
	internal var empId: String
	internal var name: String
	internal var dob: Date
	internal var monthlySalary: Float
	internal var rate: Float
	internal var role: String
	internal var employeeVehicle: Vehicle?
	
	private var nbBugs : Int
	
	var description: String{
		return "\((self as Employee).getDescription()) and corrected \(getNoOfBugs()) bugs.\nHis/Her estimated annual income is $\(getAnnualIncome())"
	}
	
	init(
		empId: String,
		name: String,
		dob: Date,
		nbBugs: Int,
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
		self.role = "Tester"
		self.employeeVehicle = employeeVehicle
		self.nbBugs = nbBugs
		print("We have a new Employee: \(getName()), a \(getRole().lowercased())")
	}
	
	func getNoOfBugs() -> Int {
		return nbBugs
	}
	
	mutating func setNoOfBugs(nbBugs: Int) {
		self.nbBugs = nbBugs
	}
	
	func getAnnualIncome() -> Float {
		let baseAnnualIncome = (self as Employee).getAnnualIncome()
		let bugBonus = Float(getNoOfBugs() * Tester.GAIN_FACTOR_ERROR)
		
		let annualIncome = baseAnnualIncome + bugBonus
		
		return annualIncome
	}
}

