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
	var userDefaults: Foundation.UserDefaults { get }

	func isPreloaded() -> Bool
	func savePreloaded(_ loaded: Bool)
    
    func isPurchesed() -> Bool
    func donePurchese()
    
    func checkNewUser()
}



extension UserDefaults {

	var userDefaults: Foundation.UserDefaults {
		return Foundation.UserDefaults.standard
	}

    
    
	func isPreloaded() -> Bool {
		guard let preloaded = userDefaults.value(forKey: UDKey.preloaded) as? Bool else {
			savePreloaded(false)
			return false
		}
		return preloaded
	}
    

	func savePreloaded(_ loaded: Bool) {
		userDefaults.set(loaded, forKey: UDKey.preloaded)
		userDefaults.synchronize()
	}
    
    
    func isPurchesed() -> Bool {
        guard let purchesed = userDefaults.value(forKey: UDKey.purchesed) as? Bool else { return false }
        return purchesed
    }
    
    
    func donePurchese() {
        userDefaults.setValue(true, forKey: UDKey.purchesed)
        userDefaults.synchronize()
    }
    
    
    func checkNewUser() {
        if userDefaults.value(forKey: UDKey.checked) == nil {
            if isPreloaded() == true {
                donePurchese()
            }
            userDefaults.set(true, forKey: UDKey.checked)
        }
    }
    
    
}
