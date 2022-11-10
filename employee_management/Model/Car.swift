//
//  Car.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation
import UIKit

struct Car: Vehicle {
	internal var make: String
	internal var plate: String
	internal var color: UIColor
	internal var category: String
	private var gear: String
	private var type: String
	
	var description: String{
		return "Employee has a car. \n \((self as Vehicle).getDescription())\n\t- gear type: \(getGear()) \n\t- type: \(getType())"
	}
	
	init(
		make: String,
		plate: String,
		color: UIColor,
		category: String,
		gear: String,
		type: String
	) {
		self.make = make
		self.plate = plate
		self.color = color
		self.category = category
		
		self.gear = gear
		self.type = type
	}
	
	func getGear() -> String {
		return gear
	}
	
	mutating func setGear(gear: String) {
		self.gear = gear
	}
	
	func getType() -> String {
		return type
	}
	
	mutating func setType(type: String) {
		self.type = type
	}
	
}
