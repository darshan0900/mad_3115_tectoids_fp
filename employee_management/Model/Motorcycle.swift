//
//  Motorcycle.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation
import UIKit

struct Motorcycle: Vehicle {
	internal var make: String
	internal var plate: String
	internal var color: UIColor
	internal var category: String
	
	private var sidecar: Bool
	
	var description: String{
		var desc = "Employee has a motorcycle. \n \((self as Vehicle).getDescription()) \n\t- "
		if getSidecar(){
			desc+="with"
		}else{
			desc+="without"
		}
		desc+=" sidecar"
		return desc
	}
	
	init(
		make: String,
		plate: String,
		color: UIColor,
		category: String,
		sidecar: Bool
	) {
		self.make = make
		self.plate = plate
		self.color = color
		self.category = category
		
		self.sidecar = sidecar
	}
	
	func getSidecar() -> Bool {
		return sidecar
	}
	
	mutating func setSidecar(sidecar: Bool) {
		self.sidecar = sidecar
	}
	
}
