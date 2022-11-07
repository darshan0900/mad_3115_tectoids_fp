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
	
	private var nbClients : Int
	
	override var description: String{
		return "\(super.description) He/She has brought \(getNoOfClients()) new clients.\nHis/Her estimated annual income is $\(getAnnualIncome())"
	}
	
	init(
		name: String,
		dob: Date,
		nbClients: Int,
		monthlySalary: Float,
		rate: Float = DEFAULT_OCCUPATION_RATE,
		employeeVehicle: Vehicle? = nil
	) {
		self.nbClients = nbClients
		super.init(
			name: name,
			dob: dob,
			monthlySalary: monthlySalary,
			rate: rate,
			role: "Manager",
			employeeVehicle: employeeVehicle
		)
	}
	
	func getNoOfClients() -> Int {
		return nbClients
	}
	
	func setNoOfClients(nbClients: Int) {
		self.nbClients = nbClients
	}
	
	override func getAnnualIncome() -> Float {
		let baseAnnualIncome = super.getAnnualIncome()
		let clientBonus = Float(getNoOfClients() * Manager.GAIN_FACTOR_CLIENT)
		
		let annualIncome = baseAnnualIncome + clientBonus
		
		return annualIncome
	}
}
