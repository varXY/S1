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

//	var dics: [SwiftDic]!
//	var dicIndex = 0

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


//		let isNotFirstTime = isPreloaded() ? true : true
		let isNotFirstTime = isPreloaded()
		print(isNotFirstTime)
		if isNotFirstTime == false {
			savePreloadedwords { self.setUpUI() }
			savePreloaded(true)
		} else {
			setUpUI()
		}

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
//		dics = allSwiftDics()
//		let timer = NSTimer(timeInterval: 0.8, target: self, selector: #selector(printDics), userInfo: nil, repeats: true)
//		NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
//	}
//
//	func printDics() {
//		if dicIndex < dics.count {
//			let array = [String(dics[dicIndex].index!), dics[dicIndex].word!, dics[dicIndex].meaning!, dics[dicIndex].code!]
//			print(array, separator: "", terminator: ", ")
//			dicIndex += 1
//		} else {
//			print("...Done...")
//		}
//	}

	func setUpUI() {
		resultsOnTable = AllResult()

		tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        tableView.separatorColor = UIColor(red: 67/255, green: 69/255, blue: 81/255, alpha: 1.0)
		tableView.sectionIndexColor = UIColor(red: 150/255, green: 153/255, blue: 172/255, alpha: 1.0)
		tableView.sectionIndexBackgroundColor = UIColor.clearColor()
		view.addSubview(tableView)

		searchBar.placeholder = "搜索"
		searchBar.tintColor = UIColor.plainWhite()
		searchBar.barTintColor = UIColor.backgroundBlack_light()
		UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = UIColor.whiteColor()
		searchBar.searchBarStyle = .Minimal
        searchBar.autoresizingMask = .FlexibleWidth
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
        if isPurchesed() {
            let newWordVC = NewWordViewController()
            newWordVC.delegate = self
            let navi = NavigationController(rootViewController: NewWordViewController())
            presentViewController(navi, animated: true, completion: nil)
        } else {
            presentViewController(NavigationController(rootViewController: BuyViewController()), animated: true, completion: nil)
        }
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
		label.backgroundColor = UIColor.backgroundBlack_light()
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
		cell.selectedBackgroundView!.backgroundColor = UIColor(red: 51/255, green: 59/255, blue: 79/255, alpha: 1.0)

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
            let oldResults = self.resultsOnTable
            self.resultsOnTable = self.AllResult()
            
            if self.resultsOnTable.count != oldResults.count {
                let indexSet = NSIndexSet(index: indexPath.section)
                tableView.deleteSections(indexSet, withRowAnimation: .Automatic)
            } else {
                let indexPaths = [indexPath]
                tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
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