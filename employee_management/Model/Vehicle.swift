//
//  Vehicle.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation
import UIKit

protocol Vehicle: CustomStringConvertible {
	var make : String {get set}
	var plate : String {get set}
	var color : UIColor {get set}
	var category : String {get set}
}
extension Vehicle{
	
	func getDescription()-> String {
		return "\t- make: \(getMake()) \n\t- plate: \(getPlate()) \n\t- color: \(getColor().accessibilityName.capitalized) \n\t- category: \(getCategory())"
	}
	
	func getMake () -> String{
		return make
	}
	
	mutating func setMake (make: String) {
		self.make = make
	}
	
	func getPlate () -> String {
		return plate
	}
	
	mutating func setPlate (plate: String) {
		self.plate = plate
	}
	
	func getColor () -> UIColor{
		return color
	}
	
	mutating func setColor (color: UIColor) {
		self.color = color
	}
	
	func getCategory() -> String {
		return category
	}
	
	mutating func setCategory(category: String) {
		self.category = category
	}
}
