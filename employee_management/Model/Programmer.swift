//
//  Programmer.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Programmer : Employee {
	static let GAIN_FACTOR_PROJECTS = 200
	
	private var nbProjects : Int
	
	override var description: String{
		return "\(super.description) and completed \(getNoOfProjects()) projects.\nHis/Her estimated annual income is $\(getAnnualIncome())"
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
		self.nbProjects = nbProjects
		super.init(
			empId: empId,
			name: name,
			dob: dob,
			monthlySalary: monthlySalary,
			rate: rate,
			role: "Programmer",
			employeeVehicle: employeeVehicle
		)
	}
	
	func getNoOfProjects() -> Int {
		return nbProjects
	}
	
	func setNoOfProjects(nbProjects: Int) {
		self.nbProjects = nbProjects
	}
	
	override func getAnnualIncome() -> Float {
		let baseAnnualIncome = super.getAnnualIncome()
		let projectBonus = Float(getNoOfProjects() * Programmer.GAIN_FACTOR_PROJECTS)
		
		let annualIncome = baseAnnualIncome + projectBonus
		
		return annualIncome
	}
}
