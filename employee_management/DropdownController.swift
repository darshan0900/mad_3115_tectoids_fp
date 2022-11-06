//
//  DropdownController.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-02.
//

import UIKit

struct DropdownItem {
	let title: String
	let value: Any
}

enum DropdownType {
	case normal
	case color
}

protocol DropdownDelegate {
	func selectItem (item: DropdownItem, selectedIndex: Int)
}

class DropdownController: UIViewController {

	var delegate: DropdownDelegate?
	var data: [DropdownItem]?
	var type: DropdownType?
	var selectedIndex: Int?
	var maxAllowedHeight: CGFloat = CGFloat(0)
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let indexPath = IndexPath(row: selectedIndex ?? 0, section: 0)
		tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
	}
	
	static func getDropdownPicker (detents: [UISheetPresentationController.Detent] = [.medium()]) -> DropdownController? {
		if let screen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Dropdown") as? DropdownController
		{
			if let sheet = screen.sheetPresentationController {
				sheet.detents = detents
				sheet.prefersScrollingExpandsWhenScrolledToEdge = false
				sheet.prefersGrabberVisible = true
			}
			return screen
		}
		return nil
	}
	
}

extension DropdownController: UITableViewDataSource, UITableViewDelegate{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.row == selectedIndex {
			cell.contentView.backgroundColor = .systemYellow
		} else{
			cell.contentView.backgroundColor = .clear
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "dropdown"), let data = data {
			
			let item = data[indexPath.row]
			
			var contentConfiguration = cell.defaultContentConfiguration()
			contentConfiguration.text = item.title.capitalized
			
			if let color = item.value as? UIColor, type == .color {
				contentConfiguration.image = UIImage(named: "square")?.withRenderingMode(.alwaysTemplate)
				contentConfiguration.imageProperties.cornerRadius = 16
				contentConfiguration.imageProperties.tintColor = color
				contentConfiguration.imageProperties.maximumSize = CGSize(width: 16.0, height: 16.0)
			}

			cell.contentConfiguration = contentConfiguration
			
			return cell
		}
		
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let data = data {
			let item = data[indexPath.row]
			delegate?.selectItem(item: item, selectedIndex: indexPath.row)
		}
	}
	
}
