//
//  ListEmployeeScreen.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-07.
//

import UIKit

class ListEmployeeScreen: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var addButton: UIButton!
	
	var searchController: UISearchController?
	var employees: [Employee] = []
	var filteredEmployees: [Employee] = []
	var isFiltering: Bool{
		return searchController?.isActive ?? false
	}
	var count = 10
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		addButton.layer.cornerRadius = addButton.layer.bounds.width / 2
		addButton.clipsToBounds = true
		
		searchController = UISearchController(searchResultsController: nil)
		if let searchController = searchController{
			searchController.searchResultsUpdater = self
			searchController.obscuresBackgroundDuringPresentation = false
			searchController.searchBar.placeholder = "Search Employees"
			
			searchController.searchBar.scopeButtonTitles = Role.allCases.map {$0.rawValue}
			searchController.searchBar.delegate = self
			
			navigationItem.searchController = searchController
			definesPresentationContext = true
		}
		
		addDummyData()
    }
	
	func addDummyData() {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		
		employees.append(
			Manager(empId: "EMP-003", name: "Lorianne Frisch", dob: formatter.date(from:"2004-11-05 21:32:00")!, nbClients: 20, monthlySalary: 60000.0, rate: 70.0, employeeVehicle: Car(make: "Renault Clio", plate: "TTT-567", color: UIColor.gray, category: "Normal", gear: "Manual", type: "Sport"))
		)
		
		employees.append(
			Tester(empId: "EMP-002", name: "Terry Jendrich", dob: formatter.date(from:"2004-11-01 21:30:00")!, nbBugs: 7, monthlySalary: 3000.0, rate: 30.0, employeeVehicle: Car(make: "Mazda", plate: "QQQ-2452", color: UIColor.red, category: "Race", gear: "Manual", type: "Sedan"))
		)
		
		employees.append(
			Programmer(empId: "EMP-001", name: "John Doe", dob: formatter.date(from: "2004-11-01 21:28:00")!, nbProjects: 8, monthlySalary: 6000.0, rate: 70.0, employeeVehicle:Motorcycle(make: "Kawasaki", plate: "FFF-546", color: UIColor.purple, category: "Normal", sidecar: false))
		)
		
		tableView.reloadData()
	}

	@IBAction func onAddPress(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let screen = storyboard.instantiateViewController(withIdentifier: "RegistrationScreen") as? RegistrationScreen {
			screen.delegate = self
			screen.empId = String(format: "EMP-%03d", employees.count+1)
			navigationController?.pushViewController(screen, animated: true)
		}
	}
	
	func filterData(text: String, category: Role? = .All) {
		var filteredData = employees
		if category != .All{
			filteredData = employees.filter {
				$0.getRole() == category?.rawValue
			}
		}
		if !text.isEmpty{
			let input = text.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
			filteredData = filteredData.filter {
				$0.getRole().lowercased().contains(input) ||
				$0.getName().lowercased().contains(input) ||
				$0.getEmpId().lowercased().contains(input)
			}
		}
		filteredEmployees = filteredData
		tableView.reloadData()
	}
}

extension ListEmployeeScreen: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var count = 0
		var title = "You don't have any employees."
		if isFiltering {
			count = filteredEmployees.count
			title = "No records with applied filters"
		} else {
			count = employees.count
		}
		if count == 0 {
			tableView.setEmptyView(title: title)
			return 0
		}
		tableView.restore()
		return count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "employee_item") as? EmployeeItemCell{
			
			var item = employees[indexPath.row]
			if isFiltering {
				item = filteredEmployees[indexPath.row]
			}
			
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
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let screen = storyboard.instantiateViewController(withIdentifier: "EmployeeScreen") as? EmployeeScreen {
			let item = employees[indexPath.row]
			screen.employee = item
			navigationController?.pushViewController(screen, animated: true)
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

extension ListEmployeeScreen: UISearchResultsUpdating{
	func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		let category = Role(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
		filterData(text: searchBar.text!, category: category)
	}
}

extension ListEmployeeScreen: UISearchBarDelegate{
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		let category = Role(rawValue:searchBar.scopeButtonTitles![selectedScope])
		filterData(text: searchBar.text!, category: category)
	}
}

extension UITableView {
	func setEmptyView(title: String) {
		let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
		let titleLabel = UILabel()
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textColor = UIColor.label
		emptyView.addSubview(titleLabel)
		titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
		titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
		titleLabel.text = title
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.textAlignment = .center
		self.backgroundView = emptyView
		self.separatorStyle = .none
	}
	func restore() {
		self.backgroundView = nil
		self.separatorStyle = .singleLine
	}
}
