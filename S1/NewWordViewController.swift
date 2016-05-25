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

		tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = UIColor.clearColor()
		tableView.separatorStyle = .None
		tableView.sectionIndexColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
		tableView.sectionIndexBackgroundColor = UIColor.clearColor()
		view.addSubview(tableView)
		
	}

	func doneButtonTapped() {
		dismissViewControllerAnimated(true, completion: nil)
	}

	func attributedTitles() -> [NSMutableAttributedString] {
		let titles = [
			NSMutableAttributedString(string: "struct NewWord {"),
			NSMutableAttributedString(string: "  let word: String!"),
			NSMutableAttributedString(string: "  let meaning: String!"),
			NSMutableAttributedString(string: "  let sampleCode: AnyObject?"),
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
		return 5
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 50
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell")
		if cell == nil { cell = UITableViewCell(style: .Default, reuseIdentifier: "cell") }
		return cell
	}

	func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		cell.backgroundColor = UIColor.backgroundBlack()
		cell.textLabel?.textColor = UIColor.plainWhite()
		cell.textLabel?.font = UIFont.defaultFont(17)
		cell.textLabel!.attributedText = attributedTitles()[indexPath.row]
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
}