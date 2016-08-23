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
	func doneEditingSwiftDic(_ dic: SwiftDic)
	func didSaveNewWord()
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

	let rowHeight: CGFloat = 50

	var textViewRects: [CGRect]!
	var barButtonItem: UIBarButtonSystemItem!

	weak var delegate: NewWordViewControllerDelegate?

    override var preferredStatusBarStyle: UIStatusBarStyle {
		return statusBarStyle ?? .lightContent
	}
    

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.backgroundBlack()

		let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 60, height: 44))
		titleLabel.textColor = UIColor.commentGreen()
		titleLabel.font = UIFont.defaultFont(17)
		titleLabel.text = dicForEditing == nil ? "// 添加新词.swift" : "// 编辑词语.swift"
		let titleItem = UIBarButtonItem(customView: titleLabel)
		navigationItem.leftBarButtonItem = titleItem

		barButtonItem = .cancel
		setBarButtonItem(barButtonItem)

		tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = UIColor.clear
		tableView.separatorStyle = .none
		tableView.sectionIndexColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
		tableView.sectionIndexBackgroundColor = UIColor.clear
		tableView.isScrollEnabled = false
		view.addSubview(tableView)

		textViewRects = [
			CGRect(x: 147, y: 57, width: ScreenWidth - 155, height: 50),
			CGRect(x: 56, y: 150, width: ScreenWidth - 60, height: ScreenHeight / 6),
			CGRect(x: 56, y: (rowHeight * 4 + ScreenHeight / 6), width: ScreenWidth - 60, height: ScreenHeight - (64 + rowHeight * 5 + ScreenHeight / 6))
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
			let index = textViewRects.index(of: $0)!
			textView.backgroundColor = UIColor.clear
			textView.textColor = UIColor.white
			textView.tintColor = UIColor.white
			textView.font = UIFont.defaultFont(17)
			textView.keyboardType = .default
			textView.spellCheckingType = .no
			textView.autocapitalizationType = .none
			textView.autocorrectionType = .no
			textView.returnKeyType = index != 0 ? .default : .done
			textView.isUserInteractionEnabled = false
			textView.delegate = self

			tableView.addSubview(textView)

			if dicForEditing != nil {
				textView.attributedText! = stringToAttributedString(initTexts[index])

				if index != 2 {
					let text = "\"" + initTexts[index] + "\""
					textView.attributedText = stringToAttributedString(text)
				}
			}

			return textView
		}

	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if dicForEditing == nil {
			let indexPath = IndexPath(row: 1, section: 0)
			tableView(tableView, didSelectRowAt: indexPath)
		}

		delay(seconds: 0.5) { 
			self.statusBarStyle = .lightContent
			self.setNeedsStatusBarAppearanceUpdate()
		}

	}

	func setBarButtonItem(_ item: UIBarButtonSystemItem) {
		barButtonItem = item
		let button = UIBarButtonItem(barButtonSystemItem: barButtonItem, target: self, action: #selector(barButtonTapped))
		navigationItem.rightBarButtonItem = button
	}

	func barButtonTapped() {
		var editing = false
		for textView in textViews {
			if textView.isFirstResponder {
				editing = true
				break
			}
		}

		if barButtonItem == .done && editing {
			textViews.forEach({ $0.resignFirstResponder() })
			scrollToPositionForEditing(.word)

			let buttonItem: UIBarButtonSystemItem = textViews[0].text != "" && textViews[1].text != "" ? .save : .cancel
			setBarButtonItem(buttonItem)

		} else if barButtonItem == .save && !editing {
			saveContentAndDismissVC()

		}else if barButtonItem == .cancel {
			dismiss(animated: true, completion: nil)
		}
	}

	func saveContentAndDismissVC() {

		let word = String((textViews[0].text.characters.dropFirst()).dropLast())
		let meaning = String((textViews[1].text.characters.dropFirst()).dropLast())
		let newIndex = firstCharacterToIndex(word) as NSNumber

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
				let alertController = UIAlertController(title: word + " 已存在", message: "请去 " + word + " 详情页修改\n或在这里创建新词", preferredStyle: .alert)
				let action_0 = UIAlertAction(title: "退出", style: .cancel, handler: { (_) in
					self.dismiss(animated: true, completion: nil)
				})
				let action = UIAlertAction(title: "继续编辑", style: .default, handler: nil)
				alertController.addAction(action_0)
				alertController.addAction(action)
				present(alertController, animated: true, completion: nil)
				return
			}
			let entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)
			let dic = SwiftDic(entity: entity!, insertInto: nil)
			dic.index = newIndex
			dic.word = word
			dic.meaning = meaning
			dic.code = textViews[2].text
			saveSwiftDic(dic)
			delegate?.didSaveNewWord()
		}

		DispatchQueue.main.async {
			self.dismiss(animated: true, completion: nil)
		}

	}

	func attributedTitles(tapped: Bool) -> [NSMutableAttributedString] {
		let titleName = dicForEditing != nil ? "WordForEditing" : "NewWord"
		let titles = [
			stringToAttributedString("struct " + titleName + " {"),
			stringToAttributedString(tapped ? "  var word = " : "  var word: String!"),
			stringToAttributedString(tapped ? "  var meaning = " : "  var meaning: String!"),
			stringToAttributedString(""),
			stringToAttributedString(tapped ? "  var example = " : "  var example: AnyObject?"),
			stringToAttributedString(""),
			stringToAttributedString("}")
		]

		return titles
	}
}


extension NewWordViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 7
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch (indexPath as NSIndexPath).row {
		case 3: return textViewRects[1].height
		case 5: return textViewRects[2].height
		default: return rowHeight
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
		cell.backgroundColor = UIColor.backgroundBlack()
		cell.textLabel?.textColor = UIColor.plainWhite()
		cell.textLabel?.font = UIFont.defaultFont(17)

		var tapped = dicForEditing != nil
		if tapped && indexPath.section == 4 && dicForEditing.code! == "" {
			tapped = false
		}
		
		cell.textLabel!.attributedText = attributedTitles(tapped: tapped)[(indexPath as NSIndexPath).row]

		cell.selectedBackgroundView = UIView()
		cell.selectedBackgroundView!.backgroundColor = UIColor.selectedBackgroundPurple()

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		if barButtonItem != .done { setBarButtonItem(.done) }

		switch (indexPath as NSIndexPath).row {
		case 1:
			let cell = tableView.cellForRow(at: indexPath)
			cell?.textLabel!.attributedText = attributedTitles(tapped: true)[1]

			scrollToPositionForEditing(.word)
			textViews[0].becomeFirstResponder()

		case 2, 3:
			let indexPath = IndexPath(row: 2, section: 0)
			let cell = tableView.cellForRow(at: indexPath)
			cell?.textLabel!.attributedText = attributedTitles(tapped: true)[2]
			scrollToPositionForEditing(.meaning)
			textViews[1].becomeFirstResponder()

		case 4, 5:
			let indexPath = IndexPath(row: 4, section: 0)
			let cell = tableView.cellForRow(at: indexPath)
			cell?.textLabel!.attributedText = attributedTitles(tapped: true)[4]
			scrollToPositionForEditing(.example)
			textViews[2].becomeFirstResponder()

		default:
			break
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}

	func scrollToPositionForEditing(_ positionType: VisblePosition) {
		var y: CGFloat

		switch positionType {
		case .word:
			y = 0
		case .meaning:
			y = -(rowHeight * 2)
		case .example:
			y = -(rowHeight * 3 + textViewRects[1].height)
		}

		UIView.perform(.delete, on: [], options: [], animations: { 
			self.tableView.frame.origin.y = y
			}, completion: nil)
		
	}

}

extension NewWordViewController: UITextViewDelegate {

	func textViewDidBeginEditing(_ textView: UITextView) {
		textView.isUserInteractionEnabled = true
		textView.textColor = UIColor.white

		switch textView {
		case textViews[0], textViews[1]:
			var text = textView.text
			let ranges = text?.rangesOfString("\"")
			for range in ranges! {
                if range.location == 0 { text = String(describing: text?.characters.dropFirst()) }
				if range.location == text?.characters.count { text = String(describing: text?.characters.dropLast()) }
			}
			textView.text = text

		default:
			break
		}

	}

	func textViewDidChange(_ textView: UITextView) {
		switch textView {
		case textViews[0]:
			if let range = textView.text.range(of: "\n") {
                var oldText: String = textView.text
				oldText.removeSubrange(range)
				textView.text = oldText
				barButtonTapped()
			}

		default:
			break
		}

	}

	func textViewDidEndEditing(_ textView: UITextView) {
		textView.isUserInteractionEnabled = false

		switch textView {
		case textViews[0], textViews[1]:
			let oldText = textView.text
			if oldText != "" {
				textView.text = "\"" + oldText! + "\""
				textView.textColor = UIColor.stringRed()
			} else {
				textView.text = ""
				let index = textViews.index(of: textView)! + 1
				let indexPath = IndexPath(row: index, section: 0)
				let cell = tableView.cellForRow(at: indexPath)
				cell?.textLabel!.attributedText = attributedTitles(tapped: false)[index]
			}

		case textViews[2]:
			let attributedText = stringToAttributedString(textView.text)
			textView.attributedText = attributedText
			textView.font = UIFont.defaultFont(17)

			if textView.text == "" {
				let indexPath = IndexPath(row: 4, section: 0)
				let cell = tableView.cellForRow(at: indexPath)
				cell?.textLabel!.attributedText = attributedTitles(tapped: false)[4]
			}

		default:
			break
		}
	}
}



