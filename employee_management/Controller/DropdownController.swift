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
	func selectItem (item: DropdownItem, selectedIndex: Int, key: String?)
}

class DropdownController: UIViewController {

	var delegate: DropdownDelegate?
	var data: [DropdownItem]?
	var type: DropdownType?
	var selectedIndex: Int?
	var maxAllowedHeight: CGFloat = CGFloat(0)
	var key: String?
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let index = selectedIndex, index > -1{
			let indexPath = IndexPath(row: index, section: 0)
			tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
		}
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
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 45
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.contentView.backgroundColor = .clear
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "dropdown") as? DropdownCell, let data = data {
			
			let item = data[indexPath.row]
			
			cell.titleLabel.text = item.title.capitalized
			
			if let color = item.value as? UIColor, type == .color {
				cell.leftImageView.image = UIImage(named: "square")?.withRenderingMode(.alwaysTemplate)
				cell.leftImageView.layer.cornerRadius = 12
				cell.leftImageView.tintColor = color
				cell.leftImageView.layer.borderColor = UIColor.black.cgColor
				cell.leftImageView.layer.borderWidth = 1
			} else{
				cell.leftImageView.isHidden = true
			}
			
			return cell
		}
		
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let data = data {
			let item = data[indexPath.row]
			delegate?.selectItem(item: item, selectedIndex: indexPath.row, key: key)
		}
	}
	
}
