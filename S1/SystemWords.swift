//
//  Words.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

struct System {

	static let ABC_XYZ = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]

	static let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

	static let keywords = ["var", "let", "func", "import", "class", "struct", "enum", "static", "public", "private", "lazy", "where", "false", "true", "nil", "guard", "case", "return", "try", "#function", "#selector", "override", "typealias", "extension", "self", "throws", "as", "is", "break", "switch", "default", "for", "in", "continue", "if", "deinit", "else"]

	static let valueTypes = ["Bool",
	                          "String", "NSString",
	                          "Int", "UInt",
	                          "Array", "Set",
	                          "Double", "Float",
	                          "NSRange",
	                          "NSObject", "AnyObject",
	                          "CGRect"
	]

	static let chrAfterKeyWord = [
		" ", ")", ",", "\n", ":", "?", "!"
	]

	static let chrAfterNumber = [
		" ", ")", "\n", ":", ",", "]"
	]

	static let chrBeforeNumber = [
		"_", 
	] + System.ABC_XYZ
}


