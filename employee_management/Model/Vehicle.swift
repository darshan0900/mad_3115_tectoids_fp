//
//  Vehicle.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation
import UIKit

class Vehicle: CustomStringConvertible {
	private var make : String
	private var plate : String
	private var color : UIColor
	private var category : String
	
	var description: String{
		return "\t- make: \(getMake()) \n\t- plate: \(getPlate()) \n\t- color: \(getColor().accessibilityName.capitalized) \n\t- category: \(getCategory())"
	}
	
	init(
		make: String,
		plate: String,
		color: UIColor,
		category: String
	) {
		self.make = make
		self.plate = plate
		self.color = color
		self.category = category
	}
	
	func getMake () -> String{
		return make
	}
	
	func setMake (make: String) {
		self.make = make
	}
	
	func getPlate () -> String {
		return plate
	}
	
	func setPlate (plate: String) {
		self.plate = plate
	}
	
	func getColor () -> UIColor{
		return color
	}
	
	func setColor (color: UIColor) {
		self.color = color
	}
	
	func getCategory() -> String {
		return category
	}
	
	func setCategory(category: String) {
		self.category = category
	}
}
