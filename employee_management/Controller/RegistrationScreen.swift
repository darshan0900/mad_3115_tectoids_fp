//
//  RegistrationScreen.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-04.
//

import UIKit


class RegistrationScreen: UIViewController {

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
		if sender.selectedSegmentIndex == 0{
			self.employeeTypeBasedLabel.text = "Number of Clients"
		} else if sender.selectedSegmentIndex == 1{
			self.employeeTypeBasedLabel.text = "Number of Projects"
		} else {
			self.employeeTypeBasedLabel.text = "Number of Bugs"
		}
	}
	
	@IBAction func onVehicleTypeChanged(_ sender: UISegmentedControl) {
		UIView.animate(withDuration: 0.25, animations: {
			if sender.selectedSegmentIndex == 0{
				self.vehicleTypeStack.isHidden = false
				self.vehicleGearStack.isHidden = false
				self.sidecarStack.isHidden = true
			} else {
				self.vehicleTypeStack.isHidden = true
				self.vehicleGearStack.isHidden = true
				self.sidecarStack.isHidden = false
			}
		})
	}
	
	@objc func onVehicleCategoryPress(){
		openDropdown(key: "vehicleCategory", data: getVehicleCategoryData(), selectedIndex: selectedIndexes["vehicleCategory"])
	}
	
	@objc func onVehicleTypePress(){
		openDropdown(key: "vehicleType", data: getVehicleTypeData(), selectedIndex: selectedIndexes["vehicleType"])
	}
	
	@objc func onVehicleMakePress(){
		openDropdown(key: "vehicleMake", data: getVehicleMakeData(), selectedIndex: selectedIndexes["vehicleMake"])
	}
	
	@objc func onVehicleColorPress(){
		openDropdown(key: "vehicleColor", data: getVehicleColorData(), selectedIndex: selectedIndexes["vehicleColor"], type: .color)
	}
	
	@objc func onCheckboxPress(){
		let image: String
		if isSidecarChecked {
			image = "square"
		} else{
			image = "checkmark.square.fill"
		}
		isSidecarChecked = !isSidecarChecked
		UIView.transition(with: sidecarCheckboxImage,
						  duration: 0.25,
						  options: .transitionCrossDissolve,
						  animations: { self.sidecarCheckboxImage.image = UIImage(systemName: image) },
						  completion: nil)
	}
	
	@IBAction func onSubmitPress(_ sender: UIButton) {
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
			screen.delegate = self
			screen.key = key
			screen.type = type
			screen.data = data
			screen.selectedIndex = selectedIndex
			
			self.present(screen, animated: true, completion: nil)
		}
	}
	
	func resetSelectedIndexes() {
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
