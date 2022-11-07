//
//  Motorcycle.swift
//  employee_management
//
//  Created by Jayesh Khistria on 2022-11-01.
//

import Foundation
import UIKit

class Motorcycle: Vehicle {
	private var sidecar: Bool
	
	override var description: String{
		var desc = "Employee has a motorcycle. \n \(super.description) \n\t- "
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
		self.sidecar = sidecar
		
		super.init(
			make: make,
			plate: plate,
			color: color,
			category: category
		)
	}
	
	func getSidecar() -> Bool {
		return sidecar
	}
	
	func setSidecar(sidecar: Bool) {
		self.sidecar = sidecar
	}
	
}
