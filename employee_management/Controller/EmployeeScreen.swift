//
//  EmployeeScreen.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-07.
//

import UIKit

class EmployeeScreen: UIViewController {

	@IBOutlet weak var empIdLabel: UILabel!
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var ageLabel: UILabel!
	
	
	@IBOutlet weak var roleLabel: UILabel!
	@IBOutlet weak var annualIncomeLabel: UILabel!
	@IBOutlet weak var occupationRateLabel: UILabel!
	@IBOutlet weak var bonusTitle: UILabel!
	@IBOutlet weak var bonusLabel: UILabel!
	
	@IBOutlet weak var vehicleKindLabel: UILabel!
	@IBOutlet weak var vehicleCategoryLabel: UILabel!
	@IBOutlet weak var vehicleTypeLabel: UILabel!
	@IBOutlet weak var vehicleMakeLabel: UILabel!
	
	@IBOutlet weak var vehicleColorImage: UIImageView!
	@IBOutlet weak var vehicleColorLabel: UILabel!
	
	@IBOutlet weak var vehiclePlateLabel: UILabel!
	@IBOutlet weak var vehicleGearLabel: UILabel!

	@IBOutlet weak var sidecarLabel: UILabel!
	
	@IBOutlet weak var vehicleTypeStack: UIStackView!
	@IBOutlet weak var vehicleGearStack: UIStackView!
	@IBOutlet weak var sidecarStack: UIStackView!
	
	weak var employee: Employee?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		vehicleColorImage.image = UIImage(named: "square")?.withRenderingMode(.alwaysTemplate)
		vehicleColorImage.layer.cornerRadius = 12
		vehicleColorImage.layer.borderColor = UIColor.black.cgColor
		vehicleColorImage.layer.borderWidth = 1
		
		loadData()
    }
	
	func loadData() {
		if let employee = employee{
			empIdLabel.text = employee.getEmpId()
			
			nameLabel.text = employee.getName()
			ageLabel.text = String(employee.getAge())
			
			roleLabel.text = employee.getRole()
			occupationRateLabel.text = formatNumber(number: employee.getOccupationRate())
			var bonus = ""
			if let role = employee as? Manager{
				annualIncomeLabel.text = "$ " + formatNumber(number: role.getAnnualIncome())
				bonusLabel.text = String(role.getNoOfClients())
				bonus = "Clients"
			} else if let role = employee as? Programmer{
				annualIncomeLabel.text = "$ " + formatNumber(number: role.getAnnualIncome())
				bonusLabel.text = String(role.getNoOfProjects())
				bonus = "Projects"
			} else if let role = employee as? Tester{
				annualIncomeLabel.text = "$ " + formatNumber(number: role.getAnnualIncome())
				bonusLabel.text = String(role.getNoOfBugs())
				bonus = "Bugs"
			}
			bonusTitle.text = "# of \(bonus)"
			if let vehicle = employee.getEmployeeVehicle(){

				vehicleCategoryLabel.text = vehicle.getCategory()

				vehicleMakeLabel.text = vehicle.getMake()
				vehicleColorImage.tintColor = vehicle.getColor()
				vehicleColorLabel.text = vehicle.getColor().accessibilityName.capitalized
				vehiclePlateLabel.text = vehicle.getPlate()
				
				if let car = vehicle as? Car{
					vehicleKindLabel.text = "Car"
					vehicleTypeLabel.text = car.getType()
					vehicleGearLabel.text = car.getGear()
					sidecarStack.isHidden = true
				} else if let motorcycle = vehicle as? Motorcycle{
					vehicleKindLabel.text = "Motorcycle"
					sidecarLabel.text = motorcycle.getSidecar() ? "Yes" : "No"
					vehicleTypeStack.isHidden = true
					vehicleGearStack.isHidden = true
				}
			}
			
			
		}
	}

}
