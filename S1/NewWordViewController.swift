//
//  NewWordViewController.swift
//  S1
//
//  Created by 文川术 on 5/25/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit
import CoreData

protocol NewWordViewControllerDelegate: class {
	func doneEditingSwiftDic(dic: SwiftDic)
}

class NewWordViewController: UIViewController, SwiftDicData {

	var tableView: UITableView!

	var textViews = [UITextView]()

	var statusBarStyle: UIStatusBarStyle!
	var dicForEditing: SwiftDic!

	var meaningRowVisble = false
	var sampleCodeRowVisble = false

	enum VisblePosition {
		case word, meaning, example
	}

	private let rowHeight: CGFloat = 50

	var textViewRects: [CGRect]!
	var barButtonItem: UIBarButtonSystemItem!

	weak var delegate: NewWordViewControllerDelegate?

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return statusBarStyle ?? .LightContent
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

		barButtonItem = .Cancel
		setBarButtonItem(barButtonItem)

		tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = UIColor.clearColor()
		tableView.separatorStyle = .None
		tableView.sectionIndexColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
		tableView.sectionIndexBackgroundColor = UIColor.clearColor()
		tableView.scrollEnabled = false
		view.addSubview(tableView)

		textViewRects = [
			CGRectMake(147, 57, ScreenWidth - 155, 50),
			CGRectMake(56, 150, ScreenWidth - 60, ScreenHeight / 6),
			CGRectMake(56, (rowHeight * 4 + ScreenHeight / 6), ScreenWidth - 60, ScreenHeight - (64 + rowHeight * 5 + ScreenHeight / 6))
		]

		var initTexts = [String]()
		if dicForEditing != nil {
			initTexts = [
				dicForEditing.word!,
				dicForEditing.meaning!,
				dicForEditing.code!
			]
		}

		textViews = textViewRects.map{
			let textView = UITextView(frame: $0)
			let index = textViewRects.indexOf($0)!
			textView.backgroundColor = UIColor.clearColor()
			textView.textColor = UIColor.whiteColor()
			textView.tintColor = UIColor.whiteColor()
			textView.font = UIFont.defaultFont(17)
			textView.keyboardType = index != 1 ? .WebSearch : .Default
			textView.spellCheckingType = .No
			textView.autocapitalizationType = .None
			textView.autocorrectionType = .No
			textView.returnKeyType = index != 0 ? .Default : .Done
			textView.userInteractionEnabled = false
			textView.delegate = self

			tableView.addSubview(textView)

			if dicForEditing != nil {
				textView.attributedText = stringToAttributedString(initTexts[index])

				if index == 1 {
					let text = "\"" + initTexts[1] + "\""
					textView.attributedText = stringToAttributedString(text)
				}
			}

			return textView
		}

	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		let indexPath = NSIndexPath(forRow: 1, inSection: 0)
		tableView(tableView, didSelectRowAtIndexPath: indexPath)

		delay(seconds: 0.5) { 
			self.statusBarStyle = .LightContent
			self.setNeedsStatusBarAppearanceUpdate()
		}

	}

	func setBarButtonItem(item: UIBarButtonSystemItem) {
		barButtonItem = item
		let button = UIBarButtonItem(barButtonSystemItem: barButtonItem, target: self, action: #selector(barButtonTapped))
		navigationItem.rightBarButtonItem = button
	}

	func barButtonTapped() {
		var editing = false
		for textView in textViews {
			if textView.isFirstResponder() {
				editing = true
				break
			}
		}

		if barButtonItem == .Done && editing {
			textViews.forEach({ $0.resignFirstResponder() })
			scrollToPositionForEditing(.word)

			let buttonItem: UIBarButtonSystemItem = textViews[0].text != "" && textViews[1].text != "" ? .Save : .Cancel
			setBarButtonItem(buttonItem)

		} else if barButtonItem == .Save && !editing {
			saveContentAndDismissVC()

		}else if barButtonItem == .Cancel {
			dismissViewControllerAnimated(true, completion: nil)
		}
	}

	func saveContentAndDismissVC() {

		let word = String((textViews[0].text.characters.dropFirst()).dropLast())
		let meaning = String((textViews[1].text.characters.dropFirst()).dropLast())
		let catalog: String! = String(word.characters.first!).uppercaseString

		var newIndex: NSNumber
		if let index = System.ABC_XYZ.indexOf(catalog) {
			newIndex = index as NSNumber
		} else {
			newIndex = 26 as NSNumber
		}

		if dicForEditing != nil {
			editSwiftDic(dicForEditing.word!, edited: { (dic) -> (SwiftDic) in
				dic.index = newIndex
				dic.word = word
				dic.meaning = meaning
				dic.code = self.textViews[2].text
				self.delegate?.doneEditingSwiftDic(dic)
				return dic
			})

		} else {
			if detailOfWord(word) != nil {
				let alertController = UIAlertController(title: word + " 已存在", message: "请去 " + word + " 详情页修改\n或在这里创建新词", preferredStyle: .Alert)
				let action_0 = UIAlertAction(title: "退出", style: .Destructive, handler: { (_) in
					self.dismissViewControllerAnimated(true, completion: nil)
				})
				let action = UIAlertAction(title: "继续编辑", style: .Default, handler: nil)
				alertController.addAction(action_0)
				alertController.addAction(action)
				presentViewController(alertController, animated: true, completion: nil)
				return
			}
			let entity = NSEntityDescription.entityForName("SwiftDic", inManagedObjectContext: managedContext)
			let dic = SwiftDic(entity: entity!, insertIntoManagedObjectContext: nil)
			dic.index = newIndex
			dic.word = word
			dic.meaning = meaning
			dic.code = textViews[2].text
			saveSwiftDic(dic)
		}

		dispatch_async(dispatch_get_main_queue()) {
			self.dismissViewControllerAnimated(true, completion: nil)
		}

	}

	func attributedTitles(tapped tapped: Bool) -> [NSMutableAttributedString] {
		let titles = [
			stringToAttributedString("struct NewWord {"),
			stringToAttributedString(tapped ? "  let word = " : "  let word: String!"),
			stringToAttributedString(tapped ? "  let meaning = " : "  let meaning: String!"),
			stringToAttributedString(""),
			stringToAttributedString(tapped ? "  let example = " : "  let example: AnyObject?"),
			stringToAttributedString(""),
			stringToAttributedString("}")
		]

		return titles
	}
}


extension NewWordViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 7
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		switch indexPath.row {
		case 3: return textViewRects[1].height
		case 5: return textViewRects[2].height
		default: return rowHeight
		}
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
		cell.backgroundColor = UIColor.backgroundBlack()
		cell.textLabel?.textColor = UIColor.plainWhite()
		cell.textLabel?.font = UIFont.defaultFont(17)

		let tapped = dicForEditing != nil
		cell.textLabel!.attributedText = attributedTitles(tapped: tapped)[indexPath.row]

		cell.selectedBackgroundView = UIView()
		cell.selectedBackgroundView!.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)

		return cell
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		if barButtonItem != .Done { setBarButtonItem(.Done) }

		switch indexPath.row {
		case 1:
			let cell = tableView.cellForRowAtIndexPath(indexPath)
			cell?.textLabel!.attributedText = attributedTitles(tapped: true)[1]

			scrollToPositionForEditing(.word)
			textViews[0].becomeFirstResponder()

		case 2, 3:
			let indexPath = NSIndexPath(forRow: 2, inSection: 0)
			let cell = tableView.cellForRowAtIndexPath(indexPath)
			cell?.textLabel!.attributedText = attributedTitles(tapped: true)[2]
			scrollToPositionForEditing(.meaning)
			textViews[1].becomeFirstResponder()

		case 4, 5:
			let indexPath = NSIndexPath(forRow: 4, inSection: 0)
			let cell = tableView.cellForRowAtIndexPath(indexPath)
			cell?.textLabel!.attributedText = attributedTitles(tapped: true)[4]
			scrollToPositionForEditing(.example)
			textViews[2].becomeFirstResponder()

		default:
			break
		}
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

	func scrollToPositionForEditing(positionType: VisblePosition) {
		var y: CGFloat

		switch positionType {
		case .word:
			y = 0
		case .meaning:
			y = -(rowHeight * 2)
		case .example:
			y = -(rowHeight * 3 + textViewRects[1].height)
		}

		UIView.performSystemAnimation(.Delete, onViews: [], options: [], animations: { 
			self.tableView.frame.origin.y = y
			}, completion: nil)
		
	}

}

extension NewWordViewController: UITextViewDelegate {

	func textViewDidBeginEditing(textView: UITextView) {
		textView.userInteractionEnabled = true
		textView.textColor = UIColor.whiteColor()

		switch textView {
		case textViews[0], textViews[1]:
			var text = textView.text
			let ranges = text.rangesOfString("\"")
			for range in ranges {
				if range.location == 0 { text = String(text.characters.dropFirst()) }
				if range.location == text.characters.count { text = String(text.characters.dropLast()) }
			}
			textView.text = text

		default:
			break
		}

	}

	func textViewDidChange(textView: UITextView) {
		switch textView {
		case textViews[0]:
			if let range = textView.text.rangeOfString("\n") {
				var oldText = textView.text
				oldText.removeRange(range)
				textView.text = oldText
				barButtonTapped()
			}

		default:
			break
		}

	}

	func textViewDidEndEditing(textView: UITextView) {
		textView.userInteractionEnabled = false

		switch textView {
		case textViews[0], textViews[1]:
			let oldText = textView.text
			if oldText != "" {
				textView.text = "\"" + oldText + "\""
				textView.textColor = UIColor.stringRed()
			} else {
				textView.text = ""
				let index = textViews.indexOf(textView)! + 1
				let indexPath = NSIndexPath(forRow: index, inSection: 0)
				let cell = tableView.cellForRowAtIndexPath(indexPath)
				cell?.textLabel!.attributedText = attributedTitles(tapped: false)[index]
			}

		case textViews[2]:
			let attributedText = stringToAttributedString(textView.text)
			textView.attributedText = attributedText
			textView.font = UIFont.defaultFont(17)

			if textView.text == "" {
				let indexPath = NSIndexPath(forRow: 4, inSection: 0)
				let cell = tableView.cellForRowAtIndexPath(indexPath)
				cell?.textLabel!.attributedText = attributedTitles(tapped: false)[4]
			}

		default:
			break
		}
	}
}



