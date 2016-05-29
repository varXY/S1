//
//  DetailViewController.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

	var pointerView: PointerView!
	var xyScrollView: XYScrollView!
	var editButton: UIButton!

	var resultsOnTable: [[String]]!

	var initTopDetailIndex: (Int, Int)!

	var statusBarHidden = true

	override func prefersStatusBarHidden() -> Bool {
		return statusBarHidden
	}

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .Default
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setUpBars()

		pointerView = PointerView()
		view = pointerView

		xyScrollView = XYScrollView(allResult: resultsOnTable, topDetailIndex: initTopDetailIndex)
		xyScrollView.XYDelegate = self
		view.addSubview(xyScrollView)

		editButton = UIButton(type: .InfoLight)
		editButton.frame = CGRectMake(ScreenWidth - 40, 16, 30, 30)
		editButton.addTarget(self, action: #selector(editButtonTouchDown), forControlEvents: .TouchDown)
		editButton.addTarget(self, action: #selector(editButtonTouchUpOutside), forControlEvents: .TouchUpOutside)
		editButton.addTarget(self, action: #selector(editButtonTapped), forControlEvents: .TouchUpInside)
		editButton.exclusiveTouch = true
		view.addSubview(editButton)
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		statusBarHidden = true
		setNeedsStatusBarAppearanceUpdate()
		navigationController?.setToolbarHidden(false, animated: true)
	}

	func setUpBars() {
		navigationController?.navigationBarHidden = true
		navigationController?.toolbarHidden = false
		navigationController?.toolbar.tintColor = UIColor.plainWhite()

		let backButton = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: #selector(backButtonTapped))
		let nextButton = UIBarButtonItem(barButtonSystemItem: .FastForward, target: self, action: #selector(nextButtonTapped))
		let priviousButton = UIBarButtonItem(barButtonSystemItem: .Rewind, target: self, action: #selector(priviousButtonTapped))
		let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)

		setToolbarItems([backButton, space, space, space, nextButton, priviousButton], animated: true)
		let rect = CGRectMake(0, 0, ScreenWidth, 49)
		navigationController?.toolbar.setBackgroundImage(UIImage.imageWithColor(UIColor.clearColor(), rect: rect), forToolbarPosition: .Any, barMetrics: .Default)
		navigationController?.toolbar.setShadowImage(UIImage.imageWithColor(UIColor.clearColor(), rect: CGRectMake(0, 0, 10, 10)), forToolbarPosition: .Any)
	}

	func editButtonTouchDown() {
		xyScrollView.userInteractionEnabled = false
	}

	func editButtonTouchUpOutside() {
		xyScrollView.userInteractionEnabled = true
	}

	func editButtonTapped() {
		let newWordVC = NewWordViewController()
		newWordVC.statusBarStyle = .Default
		newWordVC.dicForEditing = xyScrollView.dicFromIndex(xyScrollView.theTopIndex)
		newWordVC.delegate = self

		statusBarHidden = false
		setNeedsStatusBarAppearanceUpdate()
		presentViewController(NavigationController(rootViewController: newWordVC), animated: true, completion: nil)

		xyScrollView.userInteractionEnabled = true
	}

	func backButtonTapped() {
		navigationController?.popViewControllerAnimated(true)
	}

	func nextButtonTapped() {
		xyScrollView.scrolledType = .Down
		xyScrollViewWillScroll(.Down, topViewIndex: 1)
		xyScrollView.moveContentViewToTop()
	}

	func priviousButtonTapped() {
		xyScrollView.scrolledType = .Up
		xyScrollViewWillScroll(.Up, topViewIndex: 1)
		xyScrollView.moveContentViewToTop()
	}
}

extension DetailViewController: XYScrollViewDelegate {

	func scrollTypeDidChange(type: XYScrollType) {
		pointerView.showPointer(type)
	}

	func xyScrollViewWillScroll(scrollType: XYScrollType, topViewIndex: Int) {
		pointerView.hidePointersAndLabels()
	}

	func xyScrollViewDidScroll(scrollType: XYScrollType, topViewIndex: Int) {
		switch scrollType {
		case .Left:
			navigationController?.popViewControllerAnimated(true)
		case .Right:
			break
		default:
			break
		}

	}
}

extension DetailViewController: NewWordViewControllerDelegate {

	func didSaveNewWord() {
	}

	func doneEditingSwiftDic(dic: SwiftDic) {
		xyScrollView.changeDetailForContentView(xyScrollView.contentViews[1], dic: dic)
	}
}
