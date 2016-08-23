//
//  PaintingMethod.swift
//  S1
//
//  Created by 文川术 on 5/26/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

let initAttributes = [
	NSForegroundColorAttributeName: UIColor.plainWhite,
	NSFontAttributeName: UIFont.defaultFont(17)
]

let keywordAttributes = [
	NSForegroundColorAttributeName: UIColor.keywordPurple
]

let buildInAttributes = [
	NSForegroundColorAttributeName: UIColor.buildInBlue
]

let numberAttributes = [
	NSForegroundColorAttributeName: UIColor.numberPurple
]

let stringAttributes = [
	NSForegroundColorAttributeName: UIColor.stringRed
]

let whiteAttributes = [
	NSForegroundColorAttributeName: UIColor.plainWhite
]

let commnetGreenAttribute = [
	NSForegroundColorAttributeName: UIColor.commentGreen
]




func stringToAttributedString(_ string: String) -> NSMutableAttributedString {
	let step_0 = paintKeywordPurple(NSMutableAttributedString(string: string, attributes: initAttributes))
	let step_1 = paintNumberPurple(step_0)
	let step_2 = paintBuildInBlue(step_1)
	let step_3 = paintStringRed(step_2)
	let step_4 = paintCommentGreen(step_3)
	return step_4
}


func paintKeywordPurple(_ text: NSMutableAttributedString) -> NSMutableAttributedString {
	var ranges = [NSRange]()

	System.keywords.forEach { (keyword) in
		let unClearRanges = text.mutableString.rangesOfString(keyword)
		unClearRanges.forEach({
			let last = $0.location + $0.length == (text.mutableString as NSString).length
			let first = $0.location == 0
			let nextChr = last ? " " : (text.mutableString as NSString).substring(with: NSRange(location: $0.location + $0.length, length: 1))
			let preChr = first ? " " : (text.mutableString as NSString).substring(with: NSRange(location: $0.location - 1, length: 1))
			if System.chrAfterKeyWord.contains(nextChr) && !System.ABC_XYZ.contains(preChr.uppercased()) {
				ranges += [$0]
			}
		})
	}

	let result = text
	for range in ranges {
		result.addAttributes(keywordAttributes, range: range)
	}

	return result
}


func paintNumberPurple(_ text: NSMutableAttributedString) -> NSMutableAttributedString {

	var ranges = [NSRange]()

	System.numbers.forEach { (number) in
		let unClearRanges = text.mutableString.rangesOfString(String(number))
		unClearRanges.forEach({
			let last = $0.location + $0.length == (text.mutableString as NSString).length
			let first = $0.location == 0
			let nextChr = last ? " " : (text.mutableString as NSString).substring(with: NSRange(location: $0.location + $0.length, length: 1))
			let preChr = first ? " " : (text.mutableString as NSString).substring(with: NSRange(location: $0.location - 1, length: 1))
			if System.chrAfterNumber.contains(nextChr) && !System.chrShouldNotBeforeNumber.contains(preChr.uppercased()) {
				ranges += [$0]
			}
		})
	}

	let result = text
	for range in ranges {
		result.addAttributes(numberAttributes, range: range)
	}

	return result
}


func paintBuildInBlue(_ text: NSMutableAttributedString) -> NSMutableAttributedString {
	var ranges = [NSRange]()

	System.valueTypes.forEach { (valueType) in
		let unClearRanges = text.mutableString.rangesOfString(valueType)
		unClearRanges.forEach({
			let last = $0.location + $0.length == (text.mutableString as NSString).length
			let first = $0.location == 0
			let nextChr = last ? " " : (text.mutableString as NSString).substring(with: NSRange(location: $0.location + $0.length, length: 1))
			let preChr = first ? " " : (text.mutableString as NSString).substring(with: NSRange(location: $0.location - 1, length: 1))
			if System.chrAfterValueType.contains(nextChr) && !System.chrShouldNotBeforeValueType.contains(preChr.uppercased()) {
				ranges += [$0]
			}
		})
	}

	let result = text
	for range in ranges {
		result.addAttributes(buildInAttributes, range: range)
	}

	return result
}


func paintStringRed(_ text: NSMutableAttributedString) -> NSMutableAttributedString {
	let ranges = text.mutableString.rangesOfString("\"")

	var stringRanges = [NSRange]()
	for i in stride(from: 0, to: ranges.count, by: 2) {
		if i != ranges.count - 1 && ranges.count != 1 {
			stringRanges += [NSRange(ranges[i].location..<ranges[i + 1].location + 1)]
		}
	}

	let result = text
	for range in stringRanges {
		result.addAttributes(stringAttributes, range: range)
	}

	return result
}


func paintCommentGreen(_ text: NSMutableAttributedString) -> NSMutableAttributedString {
	let sentences = text.mutableString.components(separatedBy: "\n\n")
	var lines = [String]()
	var greenLines = [String]()

	for sentence in sentences {
		lines += sentence.components(separatedBy: "\n")
	}

	for line in lines {
		if let _ = line.range(of: "//") {
			if line.range(of: "://") == nil {
				let range: NSRange = (line as NSString).range(of: "//")
				let greenRange = NSRange(range.location..<(line.characters.count))
				let subString = (line as NSString).substring(with: greenRange)
				greenLines.append(subString)
			}
		}
	}

	let result = text
	greenLines.forEach({
		let range = result.mutableString.range(of: $0)
		result.addAttributes(commnetGreenAttribute, range: range)
	})

	return result
}
