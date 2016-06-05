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

class square {
	var width = 0
	var round: Int {
		get {
			return width * 4
		}

		set {
			width = newValue / 4
		}
	}
}

