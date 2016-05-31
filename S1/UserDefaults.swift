//
//  UserDefaults.swift
//  S1
//
//  Created by 文川术 on 5/29/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

struct UDKey {
	static let preloaded = "Preloaded"
}

protocol UserDefaults {
	var userDefaults: NSUserDefaults { get }

	func isPreloaded() -> Bool
	func savePreloaded(loaded: Bool)
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
}