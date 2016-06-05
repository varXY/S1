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
		UIView.animateWithDuration(0.5, animations: { 
			self.view.alpha = 1.0
			}) { (completed) in
				// 这是一个有参数没有返回值的闭包
		}
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

