//
//  ViewController.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-01.
//

import UIKit


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

class TestScreen: UIViewController {
	
	@IBOutlet weak var testView: UIStackView!
	
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var segmentTest: UISegmentedControl!
	var selectedIndex = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		
		
//		let datePicker = UIDatePicker()
//		datePicker.datePickerMode = .date
//		datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
//		datePicker.frame.size = CGSize(width: 0, height: 300)
//		datePicker.preferredDatePickerStyle = .wheels
//		datePicker.maximumDate = Date()
//
//		let toolbar = UIToolbar()
//		toolbar.sizeToFit()
//
//		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
//		toolbar.setItems([doneButton], animated: false)
//
//		textField.inputAccessoryView = toolbar
//		textField.inputView = datePicker
//		textField.text = formatDate(date: Date()) // todays Date
//		textField.isUserInteractionEnabled = false
		
	}
	
	@objc func dateChange(datePicker: UIDatePicker)
	{
		textField.text = formatDate(date: datePicker.date)
	}
	
	func formatDate(date: Date) -> String
	{
		let formatter = DateFormatter()
		formatter.dateFormat = "MMMM dd yyyy"
		return formatter.string(from: date)
	}

	@IBAction func onSegmentControlUpdate(_ sender: UISegmentedControl) {
		print(sender.selectedSegmentIndex)
	}
	@IBAction func onPress(_ sender: UIButton) {
//		testView.isHidden = truex
		
		if let screen = DropdownController.getDropdownPicker()
		{
			var data: [DropdownItem] = []
			for color in colors {
				data.append(DropdownItem(title: color.accessibilityName, value: color))
//				DropdownItem(title: <#T##String#>, value: <#T##Any#>)
				
			}
			
			screen.delegate = self
			screen.type = .color
			screen.data = data
			screen.selectedIndex = selectedIndex
			
			self.present(screen, animated: true, completion: nil)
		}
	}
	
}

extension TestScreen: DropdownDelegate{
	func selectItem(item: DropdownItem, selectedIndex: Int) {
		self.dismiss(animated: true)
		self.selectedIndex = selectedIndex
		print(item)
	}
}
