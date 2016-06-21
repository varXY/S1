//
//  NavigationViewController.swift
//  S0
//
//  Created by 文川术 on 5/20/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBar.barTintColor = UIColor(red: 42/255, green: 44/255, blue: 56/255, alpha: 1.0)
		navigationBar.titleTextAttributes = [
			NSForegroundColorAttributeName: UIColor.commentGreen(),
			NSFontAttributeName: UIFont.defaultFont(17)
		]
		navigationBar.tintColor = UIColor.whiteColor()
		navigationBar.translucent = true
//
		let rect = CGRectMake(0, 0, self.view.frame.width, 64)
		self.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 42/255, green: 44/255, blue: 56/255, alpha: 1.0), rect: rect), forBarMetrics: UIBarMetrics.Default)
//		self.navigationBar.shadowImage = UIImage.imageWithColor(UIColor.clearColor(), rect: CGRectMake(0, 0, 10, 10))
	}

}
