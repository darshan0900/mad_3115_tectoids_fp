//
//  ListEmployeeScreen.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-07.
//

import UIKit

class ListEmployeeScreen: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	var searchController: UISearchController?
	var employees: [Employee] = []
	var filteredEmployees: [Employee] = []
	var isSearchBarEmpty: Bool {
		return searchController?.searchBar.text?.isEmpty ?? true
	}
	var isFiltering: Bool{
		return searchController?.isActive ?? false && !isSearchBarEmpty
	}
	var count = 10
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		searchController = UISearchController(searchResultsController: nil)
		searchController!.searchResultsUpdater = self
		searchController!.obscuresBackgroundDuringPresentation = false
		searchController!.searchBar.placeholder = "Search Employees"
		navigationItem.searchController = searchController!
		definesPresentationContext = true
    }

	@IBAction func onAddPress(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let screen = storyboard.instantiateViewController(withIdentifier: "RegistrationScreen") as? RegistrationScreen {
			screen.delegate = self
			screen.empId = String(format: "EMP-%03d", employees.count+1)
			navigationController?.pushViewController(screen, animated: true)
		}
	}
	
	func filterData(text: String) {
		let input = text.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
		filteredEmployees = employees.filter {
			$0.getRole().lowercased().contains(input) ||
			$0.getName().lowercased().contains(input) ||
			$0.getEmpId().lowercased().contains(input)
		}
		tableView.reloadData()
	}
}

extension ListEmployeeScreen: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var count = 0
		if isFiltering{
			count = filteredEmployees.count
		} else {
			count = employees.count
		}
		if count == 0 {
			tableView.setEmptyView(title: "You don't have any employees.", message: "All employees will be in here.")
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
		filterData(text: searchBar.text!)
	}
}

extension UITableView {
	func setEmptyView(title: String, message: String) {
		let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
		let titleLabel = UILabel()
		let messageLabel = UILabel()
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textColor = UIColor.black
		titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
		messageLabel.textColor = UIColor.lightGray
		messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
		emptyView.addSubview(titleLabel)
		emptyView.addSubview(messageLabel)
		titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
		titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
		messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
		messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
		messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
		titleLabel.text = title
		messageLabel.text = message
		messageLabel.numberOfLines = 0
		messageLabel.textAlignment = .center
		// The only tricky part is here:
		self.backgroundView = emptyView
		self.separatorStyle = .none
	}
	func restore() {
		self.backgroundView = nil
		self.separatorStyle = .singleLine
	}
}
