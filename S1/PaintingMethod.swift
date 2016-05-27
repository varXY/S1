//
//  PaintingMethod.swift
//  S1
//
//  Created by 文川术 on 5/26/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

let initAttributes = [
	NSForegroundColorAttributeName: UIColor.plainWhite(),
	NSFontAttributeName: UIFont.defaultFont(17)
]

let keywordAttributes = [
	NSForegroundColorAttributeName: UIColor.keywordPurple()
]

let buildInAttributes = [
	NSForegroundColorAttributeName: UIColor.buildInBlue()
]

let numberAttributes = [
	NSForegroundColorAttributeName: UIColor.numberPurple()
]

let stringAttributes = [
	NSForegroundColorAttributeName: UIColor.stringRed()
]

let whiteAttributes = [
	NSForegroundColorAttributeName: UIColor.plainWhite()
]

let commnetGreenAttribute = [
	NSForegroundColorAttributeName: UIColor.commentGreen()
]

func stringToAttributedString(string: String) -> NSMutableAttributedString {
	let step_0 = paintKeywordPurple(NSMutableAttributedString(string: string, attributes: initAttributes))
	let step_1 = paintBuildInBlue(step_0)
	let step_2 = paintNumberPurple(step_1)
	let step_3 = paintWhite(step_2)
	let step_4 = paintStringRed(step_3)
	let step_5 = paintCommentGreen(step_4)
	return step_5
}

func paintKeywordPurple(text: NSMutableAttributedString) -> NSMutableAttributedString {
	var ranges = [NSRange]()

	for keyword in System.keywords {
		let unClearRanges = text.mutableString.rangesOfString(keyword)
		for range in unClearRanges {
			if range.location + range.length < (text.mutableString as NSString).length {
				let nextChr = (text.mutableString as NSString).substringWithRange(NSRange(location: range.location + range.length, length: 1))
				if nextChr == " " || nextChr == ")" || nextChr == "," || nextChr == "\n" || nextChr == ":" || nextChr == "!" || nextChr == "?" {
					ranges += [range]
				}
			}
		}

	}

	let result = text
	for range in ranges {
		print(result.mutableString.substringWithRange(range))
		result.addAttributes(keywordAttributes, range: range)
	}

	return result
}

func paintBuildInBlue(text: NSMutableAttributedString) -> NSMutableAttributedString {
	var ranges = [NSRange]()

	for valueType in System.valueTypes {
		ranges += text.mutableString.rangesOfString(valueType)
	}

	let result = text
	for range in ranges {
		result.addAttributes(buildInAttributes, range: range)
	}

	return result
}

func paintNumberPurple(text: NSMutableAttributedString) -> NSMutableAttributedString {

	var ranges = [NSRange]()

	for number in System.numbers {
		ranges += text.mutableString.rangesOfString(String(number))
	}

	let result = text
	for range in ranges {
		result.addAttributes(numberAttributes, range: range)
	}

	return result
}

func paintStringRed(text: NSMutableAttributedString) -> NSMutableAttributedString {
	let ranges = text.mutableString.rangesOfString("\"")

	var stringRanges = [NSRange]()
	for i in 0.stride(to: ranges.count, by: 2) {
		if i != ranges.count - 1 && ranges.count != 1 {
			stringRanges += [NSRange(ranges[i].location...ranges[i + 1].location)]
		}
	}

	let result = text
	for range in stringRanges {
		result.addAttributes(stringAttributes, range: range)
	}

	return result
}

func paintWhite(text: NSMutableAttributedString) -> NSMutableAttributedString {
//	let sentences = text.mutableString.componentsSeparatedByString("\n\n")
//	var lines = [String]()
//	var words = [String]()
//	var whiteWords = [String]()
//
//	for sentence in sentences {
//		lines += sentence.componentsSeparatedByString("\n")
//	}
//
//	for line in lines {
//		words += line.componentsSeparatedByString(" ")
//	}
//
//	words.forEach({
//		let word = $0.removeMarks()
//		if !System.keywords.contains(word) && Int(word) == nil && !System.valueTypes.contains(word) {
//			whiteWords.append($0.removeSelf())
//		}
//	})

	let result = text
//	whiteWords.forEach({
//		let ranges = result.mutableString.rangesOfString($0.checkBrackets())
//		print($0.checkBrackets())
//		for range in ranges {
//			result.addAttributes(whiteAttributes, range: range)
//		}
//
//	})

	return result
}

func paintCommentGreen(text: NSMutableAttributedString) -> NSMutableAttributedString {
	let sentences = text.mutableString.componentsSeparatedByString("\n\n")
	var lines = [String]()
	var greenLines = [String]()

	for sentence in sentences {
		lines += sentence.componentsSeparatedByString("\n")
	}

	for line in lines {
		if let _ = line.rangeOfString("//") {
			let range: NSRange = (line as NSString).rangeOfString("//")
			let greenRange = NSRange(range.location...(line.characters.count - 1))
			let subString = (line as NSString).substringWithRange(greenRange)
			greenLines.append(subString)
		}
	}

	let result = text
	greenLines.forEach({
		let range = result.mutableString.rangeOfString($0)
		result.addAttributes(commnetGreenAttribute, range: range)
	})

	return result
}