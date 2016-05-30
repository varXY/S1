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
	var randomModel = false

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

		xyScrollView = XYScrollView(allResult: resultsOnTable, topDetailIndex: initTopDetailIndex, random: randomModel)
		xyScrollView.XYDelegate = self
		view.addSubview(xyScrollView)

		editButton = UIButton(type: .System)
		editButton.frame = CGRectMake(ScreenWidth - 42, 12, 30, 30)
		editButton.tintColor = UIColor.whiteColor()
		editButton.setImage(UIImage(named: "EditIcon"), forState: .Normal)
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
//		navigationController?.toolbarHidden = false
		navigationController?.toolbar.tintColor = UIColor.plainWhite()

		let buttons = toolbarCustomButtons()
		buttons[0].addTarget(self, action: #selector(backButtonTapped), forControlEvents: .TouchUpInside)
		buttons[1].addTarget(self, action: #selector(nextButtonTapped), forControlEvents: .TouchUpInside)
		buttons[2].addTarget(self, action: #selector(priviousButtonTapped), forControlEvents: .TouchUpInside)

		let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)

		setToolbarItems([UIBarButtonItem(customView: buttons[0]), space, space, space, UIBarButtonItem(customView: buttons[1]), UIBarButtonItem(customView: buttons[2])], animated: true)
		let rect = CGRectMake(0, 0, ScreenWidth, 49)
		navigationController?.toolbar.setBackgroundImage(UIImage.imageWithColor(UIColor.clearColor(), rect: rect), forToolbarPosition: .Any, barMetrics: .Default)
		navigationController?.toolbar.setShadowImage(UIImage.imageWithColor(UIColor.clearColor(), rect: CGRectMake(0, 0, 10, 10)), forToolbarPosition: .Any)
	}

	func toolbarCustomButtons() -> [UIButton] {
		let transforms = [
			CGAffineTransformMakeRotation(CGFloat(90 * M_PI / 180)),
			CGAffineTransformMakeRotation(CGFloat(0 * M_PI / 180)),
			CGAffineTransformMakeRotation(CGFloat(180 * M_PI / 180))
		]

		let buttons: [UIButton] = transforms.map({
			let button = UIButton(type: .System)
			button.frame = CGRectMake(0, 0, 30, 30)
			button.setImage(UIImage(named: "DirectionIcon")!, forState: .Normal)
			button.transform = $0
			button.tintColor = UIColor.whiteColor()

			button.exclusiveTouch = true
			return button
		})

		return buttons
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
			editButton.alpha = 0.0
			navigationController?.popViewControllerAnimated(true)
		case .Right:
			randomModel = !randomModel
			xyScrollView.randomModel = randomModel
			
			let hudView = HudView.hudInView(view, animated: true)
			hudView.text = randomModel ? "随机模式" : "顺序模式"
			pointerView.changeRightLabelTextForRandomModel(randomModel)
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
