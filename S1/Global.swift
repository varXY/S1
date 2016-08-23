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
let ScreenBounds = UIScreen.main.bounds
let ScreenWidth = ScreenBounds.width
let ScreenHeight = ScreenBounds.height
let StatusBarHeight = UIApplication.shared.statusBarFrame.height

let smallBlockHeight: CGFloat = 50
let TriggerDistance: CGFloat = 50

let globalRadius: CGFloat = ScreenHeight * 0.007



// 延迟执行
func delay(seconds: Double, completion: @escaping () -> ()) {
	let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)

	DispatchQueue.main.asyncAfter(deadline: popTime) {
		completion()
	}
}


func firstCharacterToIndex(_ word: String) -> Int {
    if word == "" { return 27 }
    let catalog: String! = String(word.characters.first!).uppercased()
    var newIndex: Int
    if let index = System.ABC_XYZ.index(of: catalog) {
        newIndex = index
    } else {
        newIndex = 26
    }
    
    return newIndex
}


func findAdaptiveFontWithName(_ fontName: String, labelText: String, labelSize: CGSize, minimumSize: CGFloat) -> UIFont {
	var tempFont = UIFont()
	var tempMin = minimumSize
	var tempMax: CGFloat = 256
	var mid: CGFloat = 0
	var difference: CGFloat = 0

	while (tempMin <= tempMax) {
		mid = tempMin + (tempMax - tempMin) / 2
		tempFont = UIFont(name: fontName, size: mid)!
		difference = labelSize.height - (labelText as NSString).size(attributes: [NSFontAttributeName: tempFont]).height

		if mid == tempMin || mid == tempMax {
			if difference < 0 {
//				let size = mid > 17 ? 17 : mid
				return UIFont(name: fontName, size: mid > 17 ? 17 : mid)!
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


















