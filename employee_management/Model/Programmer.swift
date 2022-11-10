//
//  Programmer.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

struct Programmer : Employee {
	
	static let GAIN_FACTOR_PROJECTS = 200
	
	internal var empId: String
	internal var name: String
	internal var dob: Date
	internal var monthlySalary: Float
	internal var rate: Float
	internal var role: String
	internal var employeeVehicle: Vehicle?
	
	private var nbProjects : Int
	
	var description: String{
		return "\((self as Employee).getDescription()) and completed \(getNoOfProjects()) projects.\nHis/Her estimated annual income is $\(getAnnualIncome())"
	}
	
	init(
		empId: String,
		name: String,
		dob: Date,
		nbProjects: Int = 0,
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
		self.role = "Programmer"
		self.employeeVehicle = employeeVehicle
		self.nbProjects = nbProjects
		print("We have a new Employee: \(getName()), a \(getRole().lowercased())")
	}
	
	func getNoOfProjects() -> Int {
		return nbProjects
	}
	
	mutating func setNoOfProjects(nbProjects: Int) {
		self.nbProjects = nbProjects
	}
	
	func getAnnualIncome() -> Float {
		let baseAnnualIncome = (self as Employee).getAnnualIncome()
		let projectBonus = Float(getNoOfProjects() * Programmer.GAIN_FACTOR_PROJECTS)
		
		let annualIncome = baseAnnualIncome + projectBonus
		
		return annualIncome
	}
}
