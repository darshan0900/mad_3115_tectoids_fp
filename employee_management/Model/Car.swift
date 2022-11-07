//
//  Car.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation
import UIKit

class Car: Vehicle {
	private var gear: String
	private var type: String
	
	override var description: String{
		return "Employee has a car. \n \(super.description)\n\t- gear type: \(getGear()) \n\t- type: \(getType())"
	}
	
	init(
		make: String,
		plate: String,
		color: UIColor,
		category: String,
		gear: String,
		type: String
	) {
		self.gear = gear
		self.type = type
		
		super.init(
			make: make,
			plate: plate,
			color: color,
			category: category
		)
	}
	
	func getGear() -> String {
		return gear
	}
	
	func setGear(gear: String) {
		self.gear = gear
	}
	
	func getType() -> String {
		return type
	}
	
	func setType(type: String) {
		self.type = type
	}
	
}
