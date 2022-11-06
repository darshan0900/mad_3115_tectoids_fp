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
	
	private var customColorViews: [UIView] = []
	private var isSidecarChecked = false
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		addBorder(salaryView)
		addBorder(occupationRateView)
		addBorder(vehicleCategoryView)
		addBorder(vehicleTypeView)
		addBorder(vehicleMakeView)
		addBorder(vehicleColorView)
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
	
	func addBorder (_ view: UIView) {
		view.layer.borderWidth = 1
		view.layer.cornerRadius = 5
		view.layer.borderColor = UIColor(named: "textinputBorderColor")?.cgColor
		customColorViews.append(view)
//		view.layer.borderColor = UIColor(named: "textinputBorderColor")?.resolvedColor(with: self.traitCollection).cgColor
	}
}
