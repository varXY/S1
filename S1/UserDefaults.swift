//
//  UserDefaults.swift
//  S1
//
//  Created by 文川术 on 5/29/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

struct UDKey {
	static let preloaded = "SwiftDicPreloaded"
    static let purchesed = "Purchesed"
    static let checked = "Checked"
}

protocol UserDefaults {
	var userDefaults: NSUserDefaults { get }

	func isPreloaded() -> Bool
	func savePreloaded(loaded: Bool)
    
    func isPurchesed() -> Bool
    func donePurchese()
    
    func checkNewUser()
}

extension UserDefaults {

	var userDefaults: NSUserDefaults {
		return NSUserDefaults.standardUserDefaults()
	}

	func isPreloaded() -> Bool {
		guard let preloaded = userDefaults.valueForKey(UDKey.preloaded) as? Bool else {
			savePreloaded(false)
			return false
		}
		return preloaded
	}

	func savePreloaded(loaded: Bool) {
		userDefaults.setBool(loaded, forKey: UDKey.preloaded)
		userDefaults.synchronize()
	}
    
    func isPurchesed() -> Bool {
        guard let purchesed = userDefaults.valueForKey(UDKey.purchesed) as? Bool else { return false }
        return purchesed
    }
    
    func donePurchese() {
        userDefaults.setValue(true, forKey: UDKey.purchesed)
        userDefaults.synchronize()
    }
    
    func checkNewUser() {
        if userDefaults.valueForKey(UDKey.checked) == nil {
            if isPreloaded() == true {
                donePurchese()
            }
            userDefaults.setBool(true, forKey: UDKey.checked)
        }
    }
    
}