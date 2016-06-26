//
//  Global.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation
import UIKit

// 屏幕尺寸信息
let ScreenBounds = UIScreen.mainScreen().bounds
let ScreenWidth = ScreenBounds.width
let ScreenHeight = ScreenBounds.height
let StatusBarHeight = UIApplication.sharedApplication().statusBarFrame.height

let smallBlockHeight: CGFloat = 50
let TriggerDistance: CGFloat = 50

let globalRadius: CGFloat = ScreenHeight * 0.007



// 延迟执行
func delay(seconds seconds: Double, completion: () -> ()) {
	let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))

	dispatch_after(popTime, dispatch_get_main_queue()) {
		completion()
	}
}

func firstCharacterToIndex(word: String) -> Int {
    if word == "" { return 27 }
    let catalog: String! = String(word.characters.first!).uppercaseString
    var newIndex: Int
    if let index = System.ABC_XYZ.indexOf(catalog) {
        newIndex = index
    } else {
        newIndex = 26
    }
    
    return newIndex
}

func findAdaptiveFontWithName(fontName: String, labelText: String, labelSize: CGSize, minimumSize: CGFloat) -> UIFont {
	var tempFont = UIFont()
	var tempMin = minimumSize
	var tempMax: CGFloat = 256
	var mid: CGFloat = 0
	var difference: CGFloat = 0

	while (tempMin <= tempMax) {
		mid = tempMin + (tempMax - tempMin) / 2
		tempFont = UIFont(name: fontName, size: mid)!
		difference = labelSize.height - (labelText as NSString).sizeWithAttributes([NSFontAttributeName: tempFont]).height

		if mid == tempMin || mid == tempMax {
			if difference < 0 {
				let size = mid > 17 ? 17 : mid
				return UIFont(name: fontName, size: size)!
			}

			let size = mid > 17 ? 17 : mid
			return UIFont(name: fontName, size: size)!
		}

		if difference < 0 {
			tempMax = mid - 1
		} else if difference > 0 {
			tempMin = mid + 1
		} else {
			let size = mid > 17 ? 17 : mid
			return UIFont(name: fontName, size: size)!
		}
	}

	let size = mid > 17 ? 17 : mid
	return UIFont(name: fontName, size: size)!
}


















