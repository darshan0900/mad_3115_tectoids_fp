//
//  Employee.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

private func validateOccupationRate (_ rate: Float) -> Float {
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
	
	static let DEFAULT_OCCUPATION_RATE: Float = 100
	
	private let empId: String
	private let name : String
	private var dob : Date
	private var monthlySalary: Float
	private var rate : Float
	private var role : String
	private var employeeVehicle: Vehicle?
	
	var description: String{
		var desc = "Name: \(getName()), a \(getRole()) \nAge: \(getAge())\n"
		if let vehicle = employeeVehicle{
			desc += vehicle.description
		}
		desc += "\n\(getName()) has an Occupation rate: \(getOccupationRate())%"
		return desc
	}
	
	init(
		empId: String,
		name: String,
		dob: Date,
		monthlySalary: Float,
		rate: Float = DEFAULT_OCCUPATION_RATE,
		role : String,
		employeeVehicle: Vehicle?
	) {
		self.empId = empId
		self.name = name
		self.dob = dob
		self.monthlySalary = monthlySalary
		// Validating occupation rate as per the given scenarios
		self.rate = validateOccupationRate(rate)
		self.role = role
		self.employeeVehicle = employeeVehicle
		print("We have a new Employee: \(getName()), a \(getRole().lowercased())")
	}
	
	func getEmpId() -> String {
		return empId
	}
	func getName() -> String {
		return name
	}
	
	func getDob() -> Date {
		return dob
	}
	
	func setDob(dob: Date) {
		self.dob = dob
	}
	
	func getAnnualIncome() -> Float {
		return monthlySalary * 12
	}
	
	func getOccupationRate() -> Float {
		return rate
	}
	
	func setOccupationRate(rate: Float) {
		self.rate = validateOccupationRate(rate)
	}
	
	func getRole() -> String {
		return role
	}
	
	func setRole(role: String) {
		self.role = role
	}
	
	func getAge() -> Int {
		let now = Date()
		let calendar = Calendar.current
		
		let ageComponents = calendar.dateComponents([.year], from: dob, to: now)
		let age = ageComponents.year!
		return age
	}
	
	func getEmployeeVehicle () -> Vehicle? {
		return employeeVehicle
	}
	
	func setEmployeeVehicle (employeeVehicle: Vehicle) {
		self.employeeVehicle = employeeVehicle
	}
	
}
