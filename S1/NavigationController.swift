//
//  NavigationViewController.swift
//  S0
//
//  Created by 文川术 on 5/20/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit


class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
    

    
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBar.barTintColor = UIColor.barBackgoundBlack
		navigationBar.titleTextAttributes = [
			NSForegroundColorAttributeName: UIColor.commentGreen,
			NSFontAttributeName: UIFont.defaultFont(17)
		]
		navigationBar.tintColor = UIColor.white
		navigationBar.isTranslucent = true

		let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
		self.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.barBackgoundBlack, rect: rect), for: UIBarMetrics.default)
        
//		self.navigationBar.shadowImage = UIImage.imageWithColor(UIColor.clearColor(), rect: CGRectMake(0, 0, 10, 10))
	}

    
}
