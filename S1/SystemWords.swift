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

		"class", "case", "continue", "catch",

		"deinit", "default", "do", "dynamic", "didSet",

		"enum", "extension", "else",

		"false", "func", "fallthrough", "for",

		"get", "guard",

		"import", "init", "if", "in", "is", "infix", "inout",

		"lazy", "let",

		"mutating",

		"new", "nonmutating", "nil",

		"operator", "optional", "override", "open",

		"protocol", "postfix", "precedence", "prefix", "public", "private",

		"return", "rightset", "repeat",

		"static", "struct", "subscript", "switch", "super", "self", "Self", "set",

		"typealias", "try", "Type", "true", "throws",

		"unowned", "unowned(safe)", "unowned(unsafe)",

		"var",

		"where", "while", "weak", "willSet",

		"#column", "#file", "#function", "#line", "#selector",

		"@objc", "@NSManaged"

	]

	static let valueTypes = [

		"Array", "AnyObject",

		"Bool", "Bundle",

		"CGRect", "CGSize", "CGPoint", "CGAffineTransform", "CGFloat",

		"Double", "Data",
		
		"Error",

		"Float",

		"Int", "Int8", "Int16", "Int32", "Int64",

		"NSString", "NSNumber", "NSDate", "NSData", "NSError", "NSRange", "NSObject", "NSBundle", "NSURL", "NSArray",

		"print", 

		"Set", "String",
		
        "TimeInterval",
        
        "UInt", "UInt8",
		
		"Void",



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
		" ", ")", ",", "\n", "?", "!", "]", "<", ">", "(", "."
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


