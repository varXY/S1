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

		let view1 = UIView(frame: CGRectMake(20, 20, 280, 250))
		view1.bounds = CGRectMake(-20, -20, 280, 250)

		let view2 = UIView(frame: CGRectMake(0, 0, 100, 100))
		view1.addSubview(view2)

		print(view1.bounds)
		print(view2.bounds)

	}

}

