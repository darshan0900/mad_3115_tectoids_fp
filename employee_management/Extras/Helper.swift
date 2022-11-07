//
//  Helper.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-06.
//

import Foundation
import UIKit


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

func getVehicleMakeData() -> [DropdownItem] {
	if let data = getDataFromPlist(key: "VehicleMake") as? [String: String]{
		return createDropdownPair(data)
	}
	return []
}

func getVehicleCategoryData() -> [DropdownItem] {
	if let data = getDataFromPlist(key: "VehicleCategory") as? [String: String]{
		return createDropdownPair(data)
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
		data[color.accessibilityName] = color
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
		data.append(DropdownItem(title: key.capitalized, value: value))
	}
	return data
}
