//
//  String+.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation


extension NSMutableString {

    
	func rangesOfString(_ string: String) -> [NSRange] {
		let ranges: [NSRange]

		do {
			let regex = try NSRegularExpression(pattern: string, options: [])
			ranges = regex.matches(in: self as String, options: [], range: NSMakeRange(0, (self as String).characters.count)).map {$0.range}
		} catch {
			ranges = []
		}

		return ranges
	}

    
}




extension String {

    
	func rangesOfString(_ string: String) -> [NSRange] {
		let ranges: [NSRange]

		do {
			let regex = try NSRegularExpression(pattern: string, options: [])
			ranges = regex.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count)).map {$0.range}
		} catch {
			ranges = []
		}

		return ranges
	}

    
	func removeSelf() -> String {
		var string = self

		if let range = string.range(of: "self.") {
			string.replaceSubrange(range, with: "")
		}
		
		return string
	}

    
	func checkBrackets() -> String {
		let result = self

		let parts = result.components(separatedBy: "(")
		if parts.count == 2 {
			for part in parts {
				if part.contains(")") {
					return parts[0]
				}
			}
		}

		return result
	}

    
//	public func rangesOfString(searchString:String, options: NSStringCompareOptions = [], searchRange:Range<Index>? = nil ) -> [Range<Index>] {
//		if let range = rangeOfString(searchString, options: options, range:searchRange) {
//
//			let nextRange = Range(range.endIndex..<self.endIndex)
//			return [range] + rangesOfString(searchString, searchRange: nextRange)
//		} else {
//			return []
//		}
//	}

    
	func isUppercaseWord() -> Bool {
		return System.ABC_XYZ.contains(String(characters.prefix(1)))
	}

    
	func removeMarks() -> String {
		let marks = ["(", ")", "[", "]", "!", "?", ",", ".", ":", " ", "<", ">"]
		var result = self

		for chr in characters {
			if marks.contains(String(chr)) {
					result.replaceSubrange(result.range(of: String(chr))!, with: "")
			}
		}

		return result
	}

    
	func removeMarks_1() -> String {
		let marks = ["(", ")", "[", "]", "!", "?", ",", ".", ":"]
		var result = self

		for (index, chr) in result.characters.enumerated() {
			if marks.contains(String(chr)) {
				if index >= result.characters.count - 2 {
					result = String(result.characters.dropLast())
				} else {
					let range = Range<String.Index>(result.index(result.startIndex, offsetBy: index)..<result.index(result.startIndex, offsetBy: index + 1))
					result.replaceSubrange(range, with: "")
				}
			}
		}

		return result
	}

    
}
