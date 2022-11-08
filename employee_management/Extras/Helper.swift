//
//  Helper.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-06.
//

import Foundation
import UIKit

// Plist helper

func getDataFromPlist(key: String) -> Any? {
	if let path = Bundle.main.path(forResource: "Data", ofType: "plist"),
		let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
	{
		if let data = dict[key]{
			return data
		}else{
			return dict
		}
	}
	return nil
}


func getVehicleTypeData() -> [DropdownItem] {
	if let data = getDataFromPlist(key: "VehicleType") as? [String]{
		var formatedData: [String: String] = [:]
		for item in data{
			formatedData[item] = item
		}
		return createDropdownPair(formatedData)
	}
	return []
}

func getVehicleMakeData(vehicle: String) -> [DropdownItem] {
	if let data = getDataFromPlist(key: "VehicleMake") as? [String: String]{
		let filteredData = data.filter { $1.lowercased() == vehicle.lowercased()}
		return createDropdownPair(filteredData)
	}
	return []
}

func getVehicleCategoryData() -> [DropdownItem] {
	if let data = getDataFromPlist(key: "VehicleCategory") as? [String]{
		var formatedData: [String: String] = [:]
		for item in data{
			formatedData[item] = item
		}
		return createDropdownPair(formatedData)
	}
	return []
}

func getVehicleColorData() -> [DropdownItem] {
	let colors = [
		UIColor.black,
		UIColor.darkGray,
		UIColor.lightGray,
		UIColor.white,
		UIColor.gray,
		UIColor.red,
		UIColor.green,
		UIColor.blue,
		UIColor.cyan,
		UIColor.yellow,
		UIColor.magenta,
		UIColor.orange,
		UIColor.brown
	]
	
	var data: [String: UIColor] = [:]
	for color in colors {
		data[color.accessibilityName.capitalized] = color
	}
	return createDropdownPair(data)

}

func sortWithKeys(_ dict: [String: Any]) -> [String: Any] {
	let sorted = dict.sorted(by: {$0.key.lowercased() < $1.key.lowercased()})
	print(sorted)
	var newDict: [String: Any] = [:]
	for (key, value) in sorted {
		newDict[key] = value
	}
	print(newDict)
	return  newDict
}

func createDropdownPair(_ dict: [String: Any]) -> [DropdownItem]{
	let sorted = dict.sorted(by: {$0.key.lowercased() < $1.key.lowercased()})
	var data: [DropdownItem] = []
	for (key, value) in sorted {
		data.append(DropdownItem(title: key, value: value))
	}
	return data
}


func getSelectedSegmentValue (index: Int, key: String) -> String? {
	switch key {
	case "employeeType":
		switch index {
		case 0:
			return "Manager"
		case 1:
			return "Programmer"
		case 2:
			return "Tester"
		default:
			return nil
		}
	case "vehicleKind":
		switch index {
		case 0:
			return "Car"
		case 1:
			return "Motorcycle"
		default:
			return nil
		}
	case "vehicleGear":
		switch index {
		case 0:
			return "Automatic"
		case 1:
			return "Manual"
		default:
			return nil
		}
	default:
		return nil
	}
}

func getSelectedDropdownValue(index: Int, key: String, vehicle: String = "") -> DropdownItem? {
	var data: [DropdownItem]
	switch key {
	case "vehicleCategory":
		data = getVehicleCategoryData()
	case "vehicleType":
		data = getVehicleTypeData()
	case "vehicleMake":
		data = getVehicleMakeData(vehicle: vehicle)
	case "vehicleColor":
		data = getVehicleColorData()
	default:
		data = []
	}
	if index > -1 && data.count > 0 && index < data.count {
		return data[index]
	}else{
		return nil
	}
}

func validateCharacters (text: String) -> Bool {
	let trimString = text.trimmingCharacters(in: .whitespacesAndNewlines)
	let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
	return !(trimString.rangeOfCharacter(from: set.inverted) != nil)
}

func validate(text: String, with regex: String) -> Bool {
	// Create the regex
	guard let gRegex = try? NSRegularExpression(pattern: regex) else {
		return false
	}
	
	// Create the range
	let range = NSRange(location: 0, length: text.utf16.count)
	
	// Perform the test
	if gRegex.firstMatch(in: text, options: [], range: range) != nil {
		return true
	}
	
	return false
}

func validateLicensePlate (text: String) -> Bool {
	return validate(text: text, with: #"^[A-Z0-9]{3,4}[- ][A-Z0-9]{3,4}$"#)
}

func formatNumber(number: Float) -> String{
	let numberFormatter = NumberFormatter()
	numberFormatter.numberStyle = .decimal
	let formattedNumber = numberFormatter.string(from: NSNumber(value: number))
	return formattedNumber ?? String(number)
}
