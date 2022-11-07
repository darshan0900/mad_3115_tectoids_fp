//
//  RegistrationScreen.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-04.
//

import UIKit


class RegistrationScreen: UIViewController {

	@IBOutlet weak var scrollview: UIScrollView!
	
	@IBOutlet weak var salaryView: UIStackView!
	@IBOutlet weak var occupationRateView: UIStackView!
	
	@IBOutlet weak var vehicleCategoryView: UIStackView!
	@IBOutlet weak var vehicleTypeView: UIStackView!
	@IBOutlet weak var vehicleMakeView: UIStackView!
	@IBOutlet weak var vehicleColorView: UIStackView!
	
	@IBOutlet weak var employeeTypeBasedLabel: UILabel!
	
	@IBOutlet weak var vehicleTypeStack: UIStackView!
	@IBOutlet weak var vehicleGearStack: UIStackView!
	@IBOutlet weak var sidecarStack: UIStackView!
	
	@IBOutlet weak var sidecarCheckboxImage: UIImageView!
	
	@IBOutlet weak var vehicleCategoryLabel: UILabel!
	@IBOutlet weak var vehicleTypeLabel: UILabel!
	@IBOutlet weak var vehicleMakeLabel: UILabel!
	@IBOutlet weak var vehicleColorLabel: UILabel!
	@IBOutlet weak var vehicleColorImage: UIImageView!
	
	
	@IBOutlet weak var employeeId: UILabel!
	
	@IBOutlet weak var firstName: UITextField!
	@IBOutlet weak var lastName: UITextField!
	@IBOutlet weak var dob: UIDatePicker!
	
	@IBOutlet weak var employeeType: UISegmentedControl!
	@IBOutlet weak var monthlySalary: UITextField!
	@IBOutlet weak var occupationRate: UITextField!
	@IBOutlet weak var employeeTypeBasedBonus: UITextField!
	
	@IBOutlet weak var vehicleKind: UISegmentedControl!
	@IBOutlet weak var vehiclePlate: UITextField!
	@IBOutlet weak var vehicleGear: UISegmentedControl!
	
	private var customColorViews: [UIView] = []
	private var isSidecarChecked = false
	private var selectedIndexes: [String: Int] = [:]
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		resetSelectedIndexes()
		
		addBorder(salaryView)
		addBorder(occupationRateView)
		addBorder(vehicleCategoryView)
		addBorder(vehicleTypeView)
		addBorder(vehicleMakeView)
		addBorder(vehicleColorView)
		
		addTapOnView(view: scrollview, action: #selector(dismissKeyboard))
		addTapOnView(view: vehicleCategoryView, action: #selector(onVehicleCategoryPress))
		addTapOnView(view: vehicleTypeView, action: #selector(onVehicleTypePress))
		addTapOnView(view: vehicleMakeView, action: #selector(onVehicleMakePress))
		addTapOnView(view: vehicleColorView, action: #selector(onVehicleColorPress))
		addTapOnView(view: sidecarStack, action: #selector(self.onCheckboxPress))
		
		sidecarStack.isHidden = true
		
		vehicleColorImage.image = UIImage(named: "square")?.withRenderingMode(.alwaysTemplate)
		vehicleColorImage.layer.cornerRadius = 12
		vehicleColorImage.layer.borderColor = UIColor.black.cgColor
		vehicleColorImage.layer.borderWidth = 1
		
		dob.maximumDate =  Calendar.current.date(byAdding: .year, value: -18, to: Date())
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		if #available(iOS 13.0, *) {
			if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
				for view in customColorViews{
					view.layer.borderColor = UIColor(named: "textinputBorderColor")?.cgColor
				}
			}
		}
	}
	
	@IBAction func onEmployeeTypeChanged(_ sender: UISegmentedControl) {
		dismissKeyboard()
		if sender.selectedSegmentIndex == 0{
			self.employeeTypeBasedLabel.text = "Number of Clients"
		} else if sender.selectedSegmentIndex == 1{
			self.employeeTypeBasedLabel.text = "Number of Projects"
		} else {
			self.employeeTypeBasedLabel.text = "Number of Bugs"
		}
	}
	
	@IBAction func onVehicleKindChanged(_ sender: UISegmentedControl) {
		dismissKeyboard()
		UIView.animate(withDuration: 0.25, animations: {
			if sender.selectedSegmentIndex == 0 {
				self.vehicleTypeStack.isHidden = false
				self.vehicleGearStack.isHidden = false
				self.sidecarStack.isHidden = true
			} else {
				self.vehicleTypeStack.isHidden = true
				self.vehicleGearStack.isHidden = true
				self.sidecarStack.isHidden = false
			}
			self.selectedIndexes["vehicleMake"] = -1
			self.vehicleMakeLabel.text = "Choose One"
			self.vehicleMakeLabel.textColor = .placeholderText
		})
	}
	
	@objc func dismissKeyboard(){
		view.endEditing(true)
	}
	
	@objc func onVehicleCategoryPress(){
		openDropdown(key: "vehicleCategory", data: getVehicleCategoryData(), selectedIndex: selectedIndexes["vehicleCategory"])
	}
	
	@objc func onVehicleTypePress(){
		openDropdown(key: "vehicleType", data: getVehicleTypeData(), selectedIndex: selectedIndexes["vehicleType"])
	}
	
	@objc func onVehicleMakePress(){
		openDropdown(key: "vehicleMake", data: getVehicleMakeData(vehicle: getVehicleKind()), selectedIndex: selectedIndexes["vehicleMake"])
	}
	
	@objc func onVehicleColorPress(){
		openDropdown(key: "vehicleColor", data: getVehicleColorData(), selectedIndex: selectedIndexes["vehicleColor"], type: .color)
	}
	
	@objc func onCheckboxPress(){
		dismissKeyboard()
		let image: String
		if isSidecarChecked {
			image = "square"
		} else {
			image = "checkmark.square.fill"
		}
		isSidecarChecked = !isSidecarChecked
		UIView.transition(with: sidecarCheckboxImage,
						  duration: 0.25,
						  options: .transitionCrossDissolve,
						  animations: { self.sidecarCheckboxImage.image = UIImage(systemName: image) },
						  completion: nil)
	}
	
	func getVehicleKind() -> String {
		if let vehicleKind = getSelectedSegmentValue(index: vehicleKind.selectedSegmentIndex, key: "vehicleKind"){
			return vehicleKind
		} else{
			return ""
		}
	}
	
	@IBAction func onSubmitPress(_ sender: UIButton) {
		guard let firstName = firstName.text else { return }
		guard let lastName = lastName.text else { return }
		
		guard let employeeType = getSelectedSegmentValue(index: employeeType.selectedSegmentIndex, key: "employeeType") else { return }
		guard let monthlySalary = monthlySalary.text else { return }
		guard let occupationRate = occupationRate.text else { return }
		guard let employeeTypeBasedBonus = employeeTypeBasedBonus.text else { return }
		
		guard let vehicleKind = getSelectedSegmentValue(index: vehicleKind.selectedSegmentIndex, key: "vehicleKind") else { return }
		guard let vehiclePlate = vehiclePlate.text else { return }
		guard let vehicleGear = getSelectedSegmentValue(index: vehicleGear.selectedSegmentIndex, key: "vehicleGear") else { return }
		
		var bonus = "bonus"
		switch employeeType {
		case "Manager":
			bonus = "clients"
		case "Programmer":
			bonus = "projects"
		case "Tester":
			bonus = "bugs"
		default:
			bonus = "bonus"
		}
		
		if firstName.isEmpty{
			showAlert(message: "Please enter first name", toFocus: self.firstName)
			return
		}
		if lastName.isEmpty{
			showAlert(message: "Please enter last name", toFocus: self.lastName)
			return
		}
		if monthlySalary.isEmpty{
			showAlert(message: "Please enter monthly salary", toFocus: self.monthlySalary)
			return
		}
		if occupationRate.isEmpty{
			showAlert(message: "Please enter occupation rate", toFocus: self.occupationRate)
			return
		}
		if employeeTypeBasedBonus.isEmpty{
			showAlert(message: "Please enter number of \(bonus)", toFocus: self.employeeTypeBasedBonus)
			return
		}
		guard let vehicleCategory = getSelectedDropdownValue(index: selectedIndexes["vehicleCategory"] ?? -1, key: "vehicleCategory") else {
			showAlert(message: "Please choose atleast one vehicle category")
			return
		}
		var vehicleType: DropdownItem?
		if vehicleKind == "Car" {
			if let temp = getSelectedDropdownValue(index: selectedIndexes["vehicleType"] ?? -1, key: "vehicleType"){
				vehicleType = temp
			} else {
				showAlert(message: "Please choose atleast one vehicle type")
				return
			}
		}
		guard let vehicleMake = getSelectedDropdownValue(index: selectedIndexes["vehicleMake"] ?? -1, key: "vehicleMake", vehicle: vehicleKind) else {
			showAlert(message: "Please choose atleast one vehicle make")
			return
		}
		guard let vehicleColor = getSelectedDropdownValue(index: selectedIndexes["vehicleColor"] ?? -1, key: "vehicleColor") else {
			showAlert(message: "Please choose atleast one vehicle color")
			return
		}
		if vehiclePlate.isEmpty{
			showAlert(message: "Please enter vehicle plate", toFocus: self.vehiclePlate)
			return
		}

		if !validateCharacters(text: firstName){
			showAlert(message: "Please enter valid first name", toFocus: self.firstName)
			return
		}
		if !validateCharacters(text: lastName){
			showAlert(message: "Please enter valid last name", toFocus: self.lastName)
			return
		}
		guard let convertedMonthlySalary = Float(monthlySalary) else {
			showAlert(message: "Please enter valid monthly salary", toFocus: self.monthlySalary)
			return
		}
		guard let convertedOccupationRate = Float(occupationRate) else {
			showAlert(message: "Please enter valid occupation rate", toFocus: self.occupationRate)
			return
		}
		guard let convertedEmployeeTypeBasedBonus = Int(employeeTypeBasedBonus) else {
			showAlert(message: "Please enter valid number of \(bonus)", toFocus: self.employeeTypeBasedBonus)
			return
		}
		
		if !validateLicensePlate(text: vehiclePlate){
			showAlert(message: "Please enter valid vehicle plate", toFocus: self.vehiclePlate)
			return
		}
		
		let name = firstName + " " + lastName
		var vehicle:Vehicle
		if vehicleKind == "Car"{
			vehicle = Car(
				make: vehicleMake.title,
				plate: vehiclePlate,
				color: vehicleColor.value as! UIColor,
				category: vehicleCategory.title,
				gear: vehicleGear,
				type: vehicleType!.title
			)
		}else{
			vehicle = Motorcycle(
				make: vehicleMake.title,
				plate: vehiclePlate,
				color: vehicleColor.value as! UIColor,
				category: vehicleCategory.title,
				sidecar: isSidecarChecked
			)
		}
		var employee: Employee?
		if employeeType == "Manager"{
			employee = Manager(
				name: name,
				dob: dob.date,
				nbClients: convertedEmployeeTypeBasedBonus,
				monthlySalary: convertedMonthlySalary,
				rate: convertedOccupationRate,
				employeeVehicle: vehicle
			)
		} else if employeeType == "Programmer"{
			employee = Programmer(
				name: name,
				dob: dob.date,
				nbProjects: convertedEmployeeTypeBasedBonus,
				monthlySalary: convertedMonthlySalary,
				rate: convertedOccupationRate,
				employeeVehicle: vehicle
			)
		} else if employeeType == "Tester"{
			employee = Tester(
				name: name,
				dob: dob.date,
				nbBugs: convertedEmployeeTypeBasedBonus,
				monthlySalary: convertedMonthlySalary,
				rate: convertedOccupationRate,
				employeeVehicle: vehicle
			)
		}
		
		print(employee)
		
		print("submitted")
		
	}
	
	private func openDropdown(key: String, data: [DropdownItem], selectedIndex: Int? = -1, type: DropdownType = .normal){
		if let screen = DropdownController.getDropdownPicker(
			detents: [.custom(resolver: { _ in
				let maxHeight = UIScreen.main.bounds.height / 2
				return min(maxHeight, CGFloat(45 * data.count) + 48)
			})]
		)
		{
			dismissKeyboard()
			
			screen.delegate = self
			screen.key = key
			screen.type = type
			screen.data = data
			screen.selectedIndex = selectedIndex
			
			self.present(screen, animated: true, completion: nil)
		}
	}
	
	func showAlert(title: String = "Oops", message: String, toFocus: UITextField? = nil) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Okay", style: .cancel,handler: {_ in
			if let textfield = toFocus {
				textfield.becomeFirstResponder()
			}
		});
		alert.addAction(action)
		present(alert, animated: true, completion:nil)
	}
	
	private func resetSelectedIndexes() {
		selectedIndexes = [
			"vehicleCategory": -1,
			"vehicleType": -1,
			"vehicleMake": -1,
			"vehicleColor": -1
		]
		vehicleColorImage.isHidden = true
	}
	
	private func addTapOnView(view: UIView, action: Selector){
		let tap = UITapGestureRecognizer(target: self, action: action)
		view.addGestureRecognizer(tap)
	}
	
	private func addBorder (_ view: UIView) {
		view.layer.borderWidth = 1
		view.layer.cornerRadius = 5
		view.layer.borderColor = UIColor(named: "textinputBorderColor")?.cgColor
		customColorViews.append(view)
	}
	
	@objc func keyboardWillShow(notification:NSNotification) {
		
		guard let userInfo = notification.userInfo else { return }
		var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
		keyboardFrame = self.view.convert(keyboardFrame, from: nil)
		
		var contentInset:UIEdgeInsets = self.scrollview.contentInset
		contentInset.bottom = keyboardFrame.size.height
		scrollview.contentInset = contentInset
	}
	
	@objc func keyboardWillHide(notification:NSNotification) {
		
		let contentInset:UIEdgeInsets = UIEdgeInsets.zero
		scrollview.contentInset = contentInset
	}
}

extension RegistrationScreen: DropdownDelegate{
	func selectItem(item: DropdownItem, selectedIndex: Int, key: String?) {
		self.dismiss(animated: true)
		if let key = key, selectedIndexes[key] != nil{
			selectedIndexes[key] = selectedIndex
			switch key {
			case "vehicleCategory":
				vehicleCategoryLabel.text = item.title
				vehicleCategoryLabel.textColor = .label
			case "vehicleType":
				vehicleTypeLabel.text = item.title
				vehicleTypeLabel.textColor = .label
			case "vehicleMake":
				vehicleMakeLabel.text = item.title
				vehicleMakeLabel.textColor = .label
			case "vehicleColor":
				vehicleColorLabel.text = item.title
				vehicleColorLabel.textColor = .label
				if let color = item.value as? UIColor{
					vehicleColorImage.isHidden = false
					vehicleColorImage.tintColor = color
				}
			default:
				print("skip")
			}
		}
	}
}

extension RegistrationScreen: UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return true
	}
}
