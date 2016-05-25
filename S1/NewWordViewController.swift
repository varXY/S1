//
//  NewWordViewController.swift
//  S1
//
//  Created by 文川术 on 5/25/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class NewWordViewController: UIViewController {

	var tableView: UITableView!

	var textViews = [UITextView]()

	var cellTitles: [NSMutableAttributedString]!

	var meaningRowVisble = false
	var sampleCodeRowVisble = false

	enum insertRowType {
		case meaningRow, sampleCodeRow
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.backgroundBlack()

		let titleLabel = UILabel(frame: CGRectMake(0, 0, ScreenWidth - 60, 44))
		titleLabel.textColor = UIColor.commentGreen()
		titleLabel.font = UIFont.defaultFont(17)
		titleLabel.text = "// 添加新词.swift"
		let titleItem = UIBarButtonItem(customView: titleLabel)
		navigationItem.leftBarButtonItem = titleItem

		let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneButtonTapped))
		navigationItem.rightBarButtonItem = doneButton

		cellTitles = attributedTitles(tapped: false)

		tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = UIColor.clearColor()
		tableView.separatorStyle = .None
		tableView.sectionIndexColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
		tableView.sectionIndexBackgroundColor = UIColor.clearColor()
		view.addSubview(tableView)

		let rects = [
			CGRectMake(145, 57, ScreenWidth - 155, 50),
			CGRectMake(50, 150, ScreenWidth - 60, ScreenHeight / 6),
			CGRectMake(50, 200 + ScreenHeight / 4, ScreenWidth - 60, ScreenHeight - (314 + ScreenHeight / 6))
		]

		textViews = rects.map{
			let textView = UITextView(frame: $0)
			textView.backgroundColor = UIColor.clearColor()
			textView.textColor = UIColor.whiteColor()
			textView.font = UIFont.defaultFont(17)
			textView.keyboardType = .NamePhonePad
			textView.userInteractionEnabled = false
			textView.delegate = self
			return textView
		}

	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		let indexPath = NSIndexPath(forRow: 1, inSection: 0)
		tableView(tableView, didSelectRowAtIndexPath: indexPath)
	}

	func doneButtonTapped() {
		dismissViewControllerAnimated(true, completion: nil)
	}

	func attributedTitles(tapped tapped: Bool) -> [NSMutableAttributedString] {
		let titles = [
			NSMutableAttributedString(string: "struct NewWord {"),
			NSMutableAttributedString(string: tapped ? "  let word = " : "  let word: String!"),
			NSMutableAttributedString(string: tapped ? "  let meaning = " : "  let meaning: String!"),
			NSMutableAttributedString(string: tapped ? "  let sampleCode = " : "  let sampleCode: AnyObject?"),
			NSMutableAttributedString(string: "}")
		]

		for title in titles {
			for keyword in System.keywords {
				let ranges = title.mutableString.rangesOfString(keyword)
				for range in ranges {
					title.addAttribute(NSForegroundColorAttributeName, value: UIColor.keywordPurple(), range: range)
				}
			}

			for valueType in System.valueTypes {
				let ranges = title.mutableString.rangesOfString(valueType)
				for range in ranges {
					title.addAttribute(NSForegroundColorAttributeName, value: UIColor.buildInBlue(), range: range)
				}
			}
		}


		return titles
	}
}


extension NewWordViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var rows = 5
		if meaningRowVisble || sampleCodeRowVisble { rows = 6 }
		if sampleCodeRowVisble && meaningRowVisble { rows = 7 }
		return rows
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		if meaningRowVisble && indexPath.row == 3 { return ScreenHeight / 6 }
		if sampleCodeRowVisble {
			if meaningRowVisble && indexPath.row == 5 { return ScreenHeight - (314 + ScreenHeight / 6) }
			if !meaningRowVisble && indexPath.row == 4 { return ScreenHeight - (314 + ScreenHeight / 6) }
		}

		return 50
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
		cell.backgroundColor = UIColor.backgroundBlack()
		cell.textLabel?.textColor = UIColor.plainWhite()
		cell.textLabel?.font = UIFont.defaultFont(17)
		cell.textLabel!.attributedText = cellTitles[indexPath.row]

		return cell
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let cell = tableView.cellForRowAtIndexPath(indexPath)

		switch indexPath.row {
		case 1:
			cellTitles[1] = attributedTitles(tapped: true)[1]
			cell?.textLabel!.attributedText = attributedTitles(tapped: true)[1]

			tableView.addSubview(textViews[0])
			textViews[0].becomeFirstResponder()
		case 2:
			cellTitles[2] = attributedTitles(tapped: true)[indexPath.row]
			cell?.textLabel!.attributedText = attributedTitles(tapped: true)[2]
			insertRow(.meaningRow)
		case 3:
			if !meaningRowVisble {
				cellTitles[3] = attributedTitles(tapped: true)[3]
				cell?.textLabel!.attributedText = attributedTitles(tapped: true)[3]
				insertRow(.sampleCodeRow)
			}
		case 4:
			if meaningRowVisble {
				cellTitles[4] = attributedTitles(tapped: true)[3]
				cell?.textLabel!.attributedText = attributedTitles(tapped: true)[3]
				insertRow(.sampleCodeRow)
			}
		default:
			break
		}
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

	func insertRow(type: insertRowType) {
		if type == .meaningRow && !meaningRowVisble {
			meaningRowVisble = true
			changeCellTitles()

			let indexPath = NSIndexPath(forRow: 3, inSection: 0)
			tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		}

		if type == .sampleCodeRow && !sampleCodeRowVisble {
			sampleCodeRowVisble = true
			changeCellTitles()

			let indexPath = NSIndexPath(forRow: meaningRowVisble ? 5 : 4, inSection: 0)
			tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		}
	}

	func changeCellTitles() {
		let empty = NSMutableAttributedString(string: "")
		if meaningRowVisble {
			cellTitles.insert(empty, atIndex: 3)
		}

		if sampleCodeRowVisble {
			if meaningRowVisble { cellTitles.insert(empty, atIndex: 5) }
			if !meaningRowVisble { cellTitles.insert(empty, atIndex: 4) }
		}
	}
	
}

extension NewWordViewController: UITextViewDelegate {

	func textViewDidBeginEditing(textView: UITextView) {
		textView.textColor = UIColor.whiteColor()
		var text = textView.text
		let ranges = text.rangesOfString("\"")
		for range in ranges {
			if range.location == 0 { text = String(text.characters.dropFirst()) }
			if range.location == text.characters.count { text = String(text.characters.dropLast()) }
		}
		textView.text = text
	}

	func textViewDidChange(textView: UITextView) {
		if textView == textViews[0] {
			if let range = textView.text.rangeOfString("\n") {
				var oldText = textView.text
				oldText.removeRange(range)
				if oldText != "" {
					textView.text = "\"" + oldText + "\""
					textView.textColor = UIColor.stringRed()
				} else {
					textView.text = ""
					let indexPath = NSIndexPath(forRow: 1, inSection: 0)
					let cell = tableView.cellForRowAtIndexPath(indexPath)
					cell?.textLabel!.attributedText = attributedTitles(tapped: false)[1]
				}

				textView.resignFirstResponder()
			}
		}
	}
}



