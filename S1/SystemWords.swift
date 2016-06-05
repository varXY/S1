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

	static let keywords = [

		"as",

		"break",

		"class", "case", "continue",

		"deinit", "default", "do", "dynamic", "dynamicType", "didSet",

		"enum", "extension", "else",

		"false", "func", "fallthrough", "for",

		"get", "guard",

		"import", "init", "if", "in", "is", "infix", "inout",

		"lazy", "let", "left",

		"mutating",

		"new", "none", "nonmutating", "nil",

		"operator", "optional", "override",

		"protocol", "postfix", "precedence", "prefix", "public", "private",

		"return", "rightset",

		"static", "struct", "subscript", "switch", "super", "self", "Self",

		"typealias", "try", "Type", "true",

		"unowned", "unowned(safe)", "unowned(unsafe)",

		"var",

		"where", "while", "weak", "willSet",

		"#column", "#file", "#function", "#line", "#selector",

	]

	static let valueTypes = [

		"Array", "AnyObject",

		"Bool",

		"CGRect", "CGSize", "CGPoint", "CGAffineTransform",

		"Double",

		"Float",

		"Int", "Int8", "Int16", "Int32", "Int64", "UInt",

		"NSString", "NSNumber", "NSDate", "NSData", "NSError", "NSRange", "NSObject", "NSBundle", "NSTimeInterval", "NSURL", "NSArray",

		"Set", "String",
		
		"Void",

		"@objc",



		"UIControl", "UIResponder", "UIWindow", "UIScreen", "UIColor", "UIEvent", "UIBezierPath", "UIFont",

		"UIView", "UITableView", "UIScrollView", "UIButton", "UILabel", "UITextField", "UITextView", "UIWebView",

		"UIViewController", "UINavigationController",

	]


	// MARK: Keyword check
	static let chrAfterKeyWord = [
		" ", ")", ",", "\n", ":", "?", "!", ".", "("
	]


	// MARK: Number check
	static let chrAfterNumber = [
		" ", ")", "\n", ":", ",", "]", ".", "<", ">", ".", "/"
		] + System.numbers.map({ String($0) })

	static let chrShouldNotBeforeNumber = [
		"_"
	] + System.ABC_XYZ


	// MARK: Value type check
	static let chrAfterValueType = [
		" ", ")", ",", "\n", "?", "!", "]", "<", ">", "("
	]

	static let chrShouldNotBeforeValueType = [

	] + System.ABC_XYZ
}

/*

### Kit

AVFoundation, AddressBook

CoreData, Contacts

Foundation

MessageUI, MapKit

StoreKit

UIKit



### Other

alpha

bounds

CG, CA

frame

NS, navigationBar

opaque

statusBar

tintColor, toolbar

UI

*/


