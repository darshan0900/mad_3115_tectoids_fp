//
//  ListEmployeeScreen.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-07.
//

import UIKit

class ListEmployeeScreen: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	var employees: [Employee] = []
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func onAddPress(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let screen = storyboard.instantiateViewController(withIdentifier: "RegistrationScreen") as? RegistrationScreen {
			screen.delegate = self
			screen.empId = String(format: "EMP-%03d", employees.count+1)
			navigationController?.pushViewController(screen, animated: true)
		}
	}
}

extension ListEmployeeScreen: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return employees.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "employee_item") as? EmployeeItemCell{
			
			let item = employees[indexPath.row]
			
			cell.empIdLabel.text = item.getEmpId()
			cell.empNameLabel.text = item.getName()
			cell.empTypeLabel.text = item.getRole()
			
			return cell
		}
		return UITableViewCell()
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete{
			employees.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .left)
		}
	}
	
}

extension ListEmployeeScreen: RegistrationDelegate{
	func addEmployee(employee: Employee) {
		navigationController?.popViewController(animated: true)
		employees.insert(employee, at: 0)
		let indexPath = IndexPath(row: 0, section: 0)
		tableView.insertRows(at: [indexPath], with: .top)
	}
}
