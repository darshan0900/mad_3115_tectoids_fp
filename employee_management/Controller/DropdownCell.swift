//
//  DropdownCell.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-06.
//

import UIKit

class DropdownCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var leftImageView: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
		if selected{
			accessoryType = .checkmark
		} else {
			accessoryType = .none
		}
    }

}
