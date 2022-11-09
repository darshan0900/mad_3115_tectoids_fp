//
//  Employee.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

func validateOccupationRate (_ rate: Float) -> Float {
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

let DEFAULT_OCCUPATION_RATE: Float = 100

protocol Employee: CustomStringConvertible {
	
	var empId: String { get }
	var name : String { get }
	var dob : Date { get set }
	var monthlySalary: Float { get set }
	var rate : Float { get set }
	var role : String { get set }
	var employeeVehicle: Vehicle? { get set }
	
}

extension Employee {
	func getDescription() -> String{
		var desc = "Name: \(getName()), a \(getRole()) \nAge: \(getAge())\n"
		if let vehicle = employeeVehicle{
			desc += vehicle.description
		}
		desc += "\n\(getName()) has an Occupation rate: \(getOccupationRate())%"
		return desc
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
	
	mutating func setDob(dob: Date) {
		self.dob = dob
	}
	
	func getAnnualIncome() -> Float {
		return monthlySalary * 12
	}
	
	func getOccupationRate() -> Float {
		return rate
	}
	
	mutating func setOccupationRate(rate: Float) {
		self.rate = validateOccupationRate(rate)
	}
	
	func getRole() -> String {
		return role
	}
	
	mutating func setRole(role: String) {
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
	
	mutating func setEmployeeVehicle (employeeVehicle: Vehicle) {
		self.employeeVehicle = employeeVehicle
	}
}
