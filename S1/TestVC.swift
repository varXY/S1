//
//  TestVC.swift
//  S1
//
//  Created by 文川术 on 6/1/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//


import UIKit


class viewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

	}

}

class testClass {
	var testArray = Dictionary<Int, String>()
	subscript(index: Int) -> String {
		set {
			testArray[index] = newValue
		}

		get {
			return ""
		}
	}
}

