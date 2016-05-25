//
//  XYScrollView.swift
//  D4
//
//  Created by 文川术 on 4/3/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

@objc enum XYScrollType: Int {
	case Up, Down, Left, Right, NotScrollYet
}

@objc protocol XYScrollViewDelegate: class {
	func xyScrollViewDidBeginScroll(begin: Bool, type: XYScrollType)
	func xyScrollViewDidScroll(scrollType: XYScrollType, topViewIndex: Int)
	optional func xyScrollViewWillScroll(scrollType: XYScrollType, topViewIndex: Int)
	optional func writeViewWillInputText(index: Int, oldText: String, colorCode: Int)
	optional func didSelectedStory(storyIndex: Int)
	func scrollTypeDidChange(type: XYScrollType)
}

class XYScrollView: UIScrollView, SwiftDicData {

	var contentViews = [UIScrollView]()

	let topOrigin = CGPoint(x: 0, y: -ScreenHeight)
	let middleOrigin = CGPoint(x: 0, y: 0)
	let bottomOrigin = CGPoint(x: 0, y: ScreenHeight)

	var theTopIndex: (Int, Int)!

	var beginScroll = false

	var doneScroll = true
	var topViewIndex = 1

	var scrolledType: XYScrollType = .NotScrollYet {
		didSet {
			XYDelegate?.scrollTypeDidChange(scrolledType)
		}
	}

	weak var XYDelegate: XYScrollViewDelegate?

	var animateTime: Double = 0.4

	init(topDetailIndex: (Int, Int)) {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.clearColor()
		contentSize = CGSize(width: frame.width, height: 0)
		alwaysBounceHorizontal = true
		commonSetUp(self)

		theTopIndex = topDetailIndex

		let origins_Y = [-ScreenHeight, 0, ScreenHeight]
		let dics = threeDic(theTopIndex)

		contentViews = origins_Y.map({
			let contentView = UIScrollView(frame: bounds)
			contentView.frame.origin.y = $0
			contentView.contentSize = CGSize(width: 0, height: frame.height)
			commonSetUp(contentView)
			contentView.alwaysBounceVertical = true

			contentView.addSubview(DetailView(swiftDic: dics[origins_Y.indexOf($0)!]))
			addSubview(contentView)
			return contentView
		})



	}

	func commonSetUp(scrollView: UIScrollView) {
		scrollView.layer.cornerRadius = globalRadius
		scrollView.clipsToBounds = true
		scrollView.exclusiveTouch = true
		scrollView.directionalLockEnabled = true
		scrollView.pagingEnabled = false
		scrollView.scrollsToTop = false
		scrollView.delegate = self
		scrollView.decelerationRate = UIScrollViewDecelerationRateFast
	}

	func threeDic(topIndex: (Int, Int)) -> [SwiftDic] {
		var threeDic = [SwiftDic]()
//		let priIndex = previousIndex(topIndex)
//		let nexIndex = nextIndex(topIndex)
		let entity = NSEntityDescription.entityForName("SwiftDic", inManagedObjectContext: managedContext)
		let test_0 = SwiftDic(entity: entity!, insertIntoManagedObjectContext: nil)
		test_0.word = "application"
		test_0.meaning = "1. 应用程序\n2. 应用；运用；使用；用于\n3. 申请；请求"
		test_0.code = "func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool\n\nlet notificationEnabled = UIApplication.sharedApplication().currentUserNotificationSettings()!.types != UIUserNotificationType.None\n\n// test\n// 2. test"

		let test_1 = SwiftDic(entity: entity!, insertIntoManagedObjectContext: nil)
		test_1.word = "additional"
		test_1.meaning = "1. 附加的；额外的；外加的\n2. 另外的；追加的；添加的"
		test_1.code = "var additionalRecipients: [CSPerson]?\n\nvar HTTPAdditionalHeaders: [NSObject : AnyObject]?\n\nfunc additionalContentForURL(_ absoluteURL: NSURL) throws -> AnyObject"

		let test_2 = SwiftDic(entity: entity!, insertIntoManagedObjectContext: nil)
		test_2.word = "active"
		test_2.meaning = "1. 活跃的；主动的；激活\n2. 忙碌的；积极的；定期进行的；起作用的"
		test_2.code = "var active: Bool\n\nfunc applicationDidBecomeActive(application: UIApplication)\n\npublic enum UIApplicationState : Int {\n    case Active\n    case Inactive\n    case Background\n}"

		threeDic = [test_0, test_1, test_2]


//		threeDic = [dicFromIndex(priIndex), dicFromIndex(topIndex), dicFromIndex(nexIndex)]

		return threeDic
	}

	func dicFromIndex(index: (Int, Int)) -> SwiftDic {
		let words = wordsFromSection(index.0)
		let word = words[index.1]
		return detailOfWord(word)!
	}

	func previousIndex(topIndex: (Int, Int)) -> (Int, Int) {
		if topIndex.1 == 0 {
			return topIndex.0 != 0 ? (topIndex.0 - 1, wordsFromSection(topIndex.0 - 1).count - 1) : (26, wordsFromSection(26).count - 1)
		} else {
			return (topIndex.0, topIndex.1 - 1)
		}
	}

	func nextIndex(topIndex: (Int, Int)) -> (Int, Int) {
		if topIndex.1 == wordsFromSection(topIndex.0).count - 1 {
			return topIndex.0 != 26 ? (topIndex.0 + 1, 0) : (0, 0)
		} else {
			return (topIndex.0, topIndex.1 + 1)
		}
	}


	func moveContentViewToTop(scrollType: XYScrollType) {
		switch scrolledType {
		case .Up:
			if doneScroll {
				doneScroll = false
				theTopIndex = previousIndex(theTopIndex)

				contentViews[0].frame.origin = middleOrigin
				contentViews[0].transform = CGAffineTransformMakeScale(0.9, 0.9)
				contentViews[0].alpha = 1.0

				animate({
					self.contentViews[0].transform = CGAffineTransformIdentity
					self.contentViews[1].frame.origin = self.bottomOrigin
					}, completion: {
						self.sendSubviewToBack(self.contentViews[1])
						self.contentViews[1].alpha = 0.0
						self.contentViews[1].frame.origin = self.topOrigin
						self.changeDetailForContentView(self.contentViews[1], dic: self.threeDic(self.theTopIndex)[0])

						self.contentViews = [self.contentViews[1], self.contentViews[0], self.contentViews[2]]
						self.doneScroll = true
				})
			}


		case .Down:
			if doneScroll {
				doneScroll = false
				theTopIndex = nextIndex(theTopIndex)

				bringSubviewToFront(contentViews[2])
				contentViews[2].alpha = 1.0

				animate({
					self.contentViews[1].alpha = 0.4
					self.contentViews[1].transform = CGAffineTransformMakeScale(0.9, 0.9)
					self.contentViews[2].frame.origin = self.middleOrigin
					}, completion: {
						self.contentViews[1].transform = CGAffineTransformIdentity
						self.contentViews[1].alpha = 0.0
						self.contentViews[1].frame.origin = self.bottomOrigin
						self.changeDetailForContentView(self.contentViews[1], dic: self.threeDic(self.theTopIndex)[2])

						self.contentViews = [self.contentViews[0], self.contentViews[2], self.contentViews[1]]
						self.doneScroll = true
				})
			}

		default:
			break
		}

	}

	func animate(animations: () -> (), completion: (() -> ())?) {
		UIView.performSystemAnimation(.Delete, onViews: [], options: [], animations: {
			animations()
			}) { (_) in
				completion!()
		}
	}

	func changeDetailForContentView(contentView: UIScrollView, dic: SwiftDic) {
		if let detailView = contentView.subviews[0] as? DetailView {
			detailView.reloadDetail(dic)
		}
	}

	func removePartOfStory(contentView: UIScrollView, labelIndex: Int) {
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}


extension XYScrollView: UIScrollViewDelegate {

	func scrollViewDidScroll(scrollView: UIScrollView) {
		if (scrollView.contentOffset.x != 0 || scrollView.contentOffset.y != 0) && !beginScroll {
			var type = XYScrollType.NotScrollYet
			if scrollView.contentOffset.x == 0 && scrollView.contentOffset.y < 0 { type = .Up }
			if scrollView.contentOffset.x == 0 && scrollView.contentOffset.y > 0 { type = .Down	}
			if scrollView.contentOffset.x < 0 && scrollView.contentOffset.y == 0 { type = .Left }
			if scrollView.contentOffset.x > 0 && scrollView.contentOffset.y == 0 { type = .Right }

			XYDelegate?.xyScrollViewDidBeginScroll(true, type: type)
			beginScroll = true
		} else if scrollView.contentOffset == CGPoint(x: 0, y: 0) {
			XYDelegate?.xyScrollViewDidBeginScroll(false, type: XYScrollType.NotScrollYet)
			beginScroll = false
		}

		if scrollView != self {
			if scrollView.contentOffset.y > TriggerDistance {
				if scrolledType != .Down { scrolledType = .Down }
			} else if scrollView.contentOffset.y < -TriggerDistance {
				if scrolledType != .Up { scrolledType = .Up }
			} else {
				if scrolledType != .NotScrollYet { scrolledType = .NotScrollYet }
			}
		} else {
			if scrollView.contentOffset.x < -TriggerDistance {
				if scrolledType != .Left { scrolledType = .Left }
			} else if scrollView.contentOffset.x > TriggerDistance {
				if scrolledType != .Right { scrolledType = .Right }
			} else {
				if scrolledType != .NotScrollYet { scrolledType = .NotScrollYet }
			}
		}

	}

	func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		XYDelegate?.xyScrollViewWillScroll?(scrolledType, topViewIndex: topViewIndex)
		moveContentViewToTop(scrolledType)
		XYDelegate?.xyScrollViewDidScroll(scrolledType, topViewIndex: topViewIndex)
		scrolledType = .NotScrollYet

	}

}







