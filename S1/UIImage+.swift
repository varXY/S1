//
//  UIImage+.swift
//  S1
//
//  Created by 文川术 on 5/27/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit


extension UIImage {

	class func imageWithColor(_ color: UIColor, rect: CGRect) -> UIImage {
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()

		context?.setFillColor(color.cgColor)
		context?.fill(rect)

		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return image!
	}
	
}
