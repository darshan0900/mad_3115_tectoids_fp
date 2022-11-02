//
//  ViewController.swift
//  employee_management
//
//  Created by Darshan Jain on 2022-11-01.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
        print("Test 1: ")
        var management = Management()
        management.hire_test1()

        // Test part 2
        print("Test 2: ")
        print("Employees description: ")
        management.hire_test2()

        // Test part 3
        print("Test 3: ")
        print("Employees description: ")
        management.hire_test3()


	}


}

