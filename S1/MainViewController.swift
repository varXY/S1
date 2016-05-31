//
//  ViewController.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SwiftDicData, UserDefaults {

	var tableView: UITableView!
	var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 44))
	var curtainView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 44))

	var resultsOnTable: [[String]]!

	var isSearching: Bool!

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.backgroundBlack()

		let titleLabel = UILabel(frame: CGRectMake(0, 0, ScreenWidth - 60, 44))
		titleLabel.textColor = UIColor.commentGreen()
		titleLabel.font = UIFont.defaultFont(17)
		titleLabel.text = "// 开发常见词汇.swift"
		let titleItem = UIBarButtonItem(customView: titleLabel)
		navigationItem.leftBarButtonItem = titleItem

		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonTapped))
		navigationItem.rightBarButtonItem = addButton

//		savePreloadedwords { self.setUpUI() }
		isPreloaded() ? setUpUI() : savePreloadedwords { self.setUpUI() }
		savePreloaded(true)

	}



	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setToolbarHidden(true, animated: true)

		if isSearching != nil && !isSearching { navigationController?.setNavigationBarHidden(false, animated: true) }

		if searchBar.text == "" {
			navigationController?.setNavigationBarHidden(false, animated: true)
			getResultsOnTable(searchString: nil)
		}

		curtainView.removeFromSuperview()
	}

//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//
//		let dics = allSwiftDics()
//		for dic in dics {
//			delay(seconds: 0.8 * Double(dics.indexOf(dic)!), completion: {
//				let array = [String(dic.index!), dic.word!, dic.meaning!, dic.code!]
//				print(array, separator: "", terminator: ", ")
//			})
//
//		}
//
//	}

	func setUpUI() {
		resultsOnTable = AllResult()

		tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = UIColor.clearColor()
		tableView.separatorStyle = .None
		tableView.sectionIndexColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
		tableView.sectionIndexBackgroundColor = UIColor.clearColor()
		view.addSubview(tableView)

		searchBar.placeholder = "搜索"
		searchBar.tintColor = UIColor.plainWhite()
		searchBar.barTintColor = UIColor.backgroundBlack()
		UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = UIColor.whiteColor()
		searchBar.searchBarStyle = .Minimal
		searchBar.delegate = self
		tableView.tableHeaderView = searchBar
		tableView.contentOffset.y = searchBar.frame.height

		curtainView.backgroundColor = UIColor.backgroundBlack()
	}

	func AllResult() -> [[String]] {
		var allResult = [[String]]()

		System.ABC_XYZ.forEach({
			let i = System.ABC_XYZ.indexOf($0)!
			let words = wordsFromSection(i)
			if words != [""] { allResult.append(words) }
		})

		return allResult
	}

	func getResultsOnTable(searchString searchString: String?) {
		if resultsOnTable != nil { resultsOnTable.removeAll() }

		if searchString == nil {
			resultsOnTable = AllResult()
		} else if searchString == "" {
			resultsOnTable = [[" "]]
		} else {
			let index = firstCharacterToIndex(searchString!)
			let sectionResults = AllResult().filter({ firstCharacterToIndex($0[0]) == index })
			let finalResult = sectionResults.count != 0 ? sectionResults[0].filter({ $0.localizedCaseInsensitiveContainsString(searchString!) }) : ["无结果"]
			resultsOnTable = finalResult.count != 0 ? [finalResult] : [["无结果"]]
		}

		if tableView != nil { tableView.reloadData() }
	}

	func addButtonTapped() {
		let newWordVC = NewWordViewController()
		newWordVC.delegate = self
		let navi = NavigationController(rootViewController: NewWordViewController())
		presentViewController(navi, animated: true, completion: nil)
	}

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return resultsOnTable.count
	}

	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if resultsOnTable[section].count != 0 {
			let index = firstCharacterToIndex(resultsOnTable[section][0])
			return " # " + System.ABC_XYZ[index]
		} else {
			return nil
		}

	}

	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let label = UILabel(frame: CGRectMake(0, 0, 20, ScreenWidth))
		label.backgroundColor = UIColor.backgroundBlack()
		label.textColor = UIColor.statementYellow()
		label.font = UIFont.defaultFont(17)

		if resultsOnTable[section].count != 0 {
			let index = firstCharacterToIndex(resultsOnTable[section][0])
			label.text = " # " + System.ABC_XYZ[index]
		} else {
			label.text = ""
		}
		
		return label
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return resultsOnTable[section].count
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 50
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell")
		if cell == nil { cell = UITableViewCell(style: .Default, reuseIdentifier: "cell") }

		cell.backgroundColor = UIColor.backgroundBlack()
		cell.textLabel?.textColor = UIColor.stringRed()
		cell.textLabel?.font = UIFont.defaultFont(17)
		cell.selectedBackgroundView = UIView()
		cell.selectedBackgroundView!.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)

		return cell
	}

	func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		cell.textLabel!.text = resultsOnTable[indexPath.section][indexPath.row]
	}

	func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
		let cell = tableView.cellForRowAtIndexPath(indexPath)
		let noResult = cell?.textLabel?.text == "无结果" || cell?.textLabel?.text == " "
		return noResult ? nil : indexPath
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.tableHeaderView?.addSubview(curtainView)

		let detailVC = DetailViewController()
		detailVC.resultsOnTable = resultsOnTable
		detailVC.initTopDetailIndex = (indexPath.section, indexPath.row)
		navigationController?.pushViewController(detailVC, animated: true)
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

	func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
		return resultsOnTable.map({ System.ABC_XYZ[firstCharacterToIndex($0[0])] })
	}

	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return isSearching == nil ? true : !isSearching
	}

	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		let alertController = UIAlertController(title: "提示", message: "删除后无法恢复，确定删除？", preferredStyle: .Alert)
		let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (_) in
			tableView.setEditing(false, animated: true)
		}
		let okAction = UIAlertAction(title: "确定", style: .Default) { (_) in
			let cell = tableView.cellForRowAtIndexPath(indexPath)!
			self.deleteSwiftDic(cell.textLabel!.text!)
			self.resultsOnTable = self.AllResult()
			let indexPaths = [indexPath]
			tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
		}

		alertController.addAction(cancelAction)
		alertController.addAction(okAction)
		presentViewController(alertController, animated: true, completion: nil)

	}

}

extension MainViewController: UISearchBarDelegate {

	func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
		isSearching = true
		if navigationController?.navigationBarHidden == false {
			navigationController?.setNavigationBarHidden(true, animated: true)
		}

		searchBar.setShowsCancelButton(true, animated: true)
		if searchBar.text == "" { getResultsOnTable(searchString: "") }
		return true
	}

	func searchBarCancelButtonClicked(searchBar: UISearchBar) {
		isSearching = false
		navigationController?.setNavigationBarHidden(false, animated: true)
		searchBar.resignFirstResponder()
		searchBar.setShowsCancelButton(false, animated: true)
		searchBar.text = nil
		getResultsOnTable(searchString: nil)
	}

	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}

	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		getResultsOnTable(searchString: searchBar.text)
	}
	
}

extension MainViewController: NewWordViewControllerDelegate {

	func didSaveNewWord() {
	}

	func doneEditingSwiftDic(dic: SwiftDic) {
	}
}