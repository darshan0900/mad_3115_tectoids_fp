//
//  Tester.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation

class Tester : Employee {
	static let GAIN_FACTOR_ERROR = 10
	
	private var nbBugs : Int
	
	override var description: String{
		return "\(super.description) and corrected \(getNoOfBugs()) bugs.\nHis/Her estimated annual income is $\(getAnnualIncome())"
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
		self.nbBugs = nbBugs
		super.init(
			empId: empId,
			name: name,
			dob: dob,
			monthlySalary: monthlySalary,
			rate: rate,
			role: "Tester",
			employeeVehicle: employeeVehicle
		)
	}
	
	func getNoOfBugs() -> Int {
		return nbBugs
	}
	
	func setNoOfBugs(nbBugs: Int) {
		self.nbBugs = nbBugs
	}
	
	override func getAnnualIncome() -> Float {
		let baseAnnualIncome = super.getAnnualIncome()
		let bugBonus = Float(getNoOfBugs() * Tester.GAIN_FACTOR_ERROR)
		
		let annualIncome = baseAnnualIncome + bugBonus
		
		return annualIncome
	}
}

