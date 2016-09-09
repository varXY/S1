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
	case up, down, left, right, notScrollYet
}



@objc protocol XYScrollViewDelegate: class {
	func xyScrollViewDidScroll(_ scrollType: XYScrollType, topViewIndex: Int)
	@objc optional func xyScrollViewWillScroll(_ scrollType: XYScrollType, topViewIndex: Int)
	@objc optional func writeViewWillInputText(_ index: Int, oldText: String, colorCode: Int)
	@objc optional func didSelectedStory(_ storyIndex: Int)
	func scrollTypeDidChange(_ type: XYScrollType)
    func speakText(_ text: String)
}



class XYScrollView: UIScrollView, SwiftDicData {

	var contentViews = [UIScrollView]()

	let topOrigin = CGPoint(x: 0, y: -ScreenHeight)
	let middleOrigin = CGPoint(x: 0, y: 0)
	let bottomOrigin = CGPoint(x: 0, y: ScreenHeight)

	var allResults: [[String]]!
	var theTopIndex: (Int, Int)!

	var beginScroll = false

    var doneScroll = true
	var topViewIndex = 1
	var randomModel = false {
		didSet {
			changeDetailForContentView(contentViews[0], dic: threeDic(theTopIndex)[0])
			changeDetailForContentView(contentViews[2], dic: threeDic(theTopIndex)[2])
		}
	}

	var randomNextIndex = (0, 0)
	var randomPreviousIndex = (0, 0)

	var scrolledType: XYScrollType = .notScrollYet {
		didSet {
			XYDelegate?.scrollTypeDidChange(scrolledType)
		}
	}

	weak var XYDelegate: XYScrollViewDelegate?

	var animateTime: Double = 0.4

    
    
	init(allResult: [[String]], topDetailIndex: (Int, Int), random: Bool) {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.clear
		contentSize = CGSize(width: frame.width, height: 0)
		alwaysBounceHorizontal = true
		commonSetUp(self)

		allResults = allResult
		theTopIndex = topDetailIndex
		randomModel = random

		let origins_Y = [-ScreenHeight, 0, ScreenHeight]
		let dics = threeDic(theTopIndex)

		contentViews = origins_Y.map({
			let index = origins_Y.index(of: $0)!
			let contentView = UIScrollView(frame: bounds)
			contentView.frame.origin.y = $0
			contentView.contentSize = CGSize(width: 0, height: frame.height)
			commonSetUp(contentView)
			contentView.alwaysBounceVertical = true
            
            let detailView = DetailView(swiftDic: dics[index])
            detailView.delegate = self
			contentView.addSubview(detailView)
			addSubview(contentView)
			return contentView
		})

		

	}

    
//	func loadOtherTwo() {
//		let dics = threeDic(theTopIndex)
//		contentViews[0].addSubview(DetailView(swiftDic: dics[0]))
//		contentViews[2].addSubview(DetailView(swiftDic: dics[2]))
//	}

    
	func commonSetUp(_ scrollView: UIScrollView) {
		scrollView.layer.cornerRadius = globalRadius
		scrollView.clipsToBounds = true
		scrollView.isExclusiveTouch = true
		scrollView.isDirectionalLockEnabled = true
		scrollView.isPagingEnabled = false
		scrollView.scrollsToTop = false
		scrollView.delegate = self
		scrollView.decelerationRate = UIScrollViewDecelerationRateFast
	}

    
	func threeDic(_ topIndex: (Int, Int)) -> [SwiftDic] {
		let indexes = !randomModel ? [previousIndex(topIndex), topIndex, nextIndex(topIndex)] : randomThreeIndex(topIndex)
		return indexes.map({ dicFromIndex($0) })
	}

    
	func dicFromIndex(_ index: (Int, Int)) -> SwiftDic {
		let word = allResults[index.0][index.1]

		let entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)
		let test_0 = SwiftDic(entity: entity!, insertInto: nil)
		test_0.word = "nil"
		test_0.meaning = "nil"
		test_0.code = "nil"

		return detailOfWord(word) == nil ? test_0 : detailOfWord(word)!
	}

    
	func previousIndex(_ topIndex: (Int, Int)) -> (Int, Int) {
		if topIndex.1 == 0 {
			return topIndex.0 != 0 ? (topIndex.0 - 1, allResults[topIndex.0 - 1].count - 1) : (allResults.count - 1, allResults.last!.count - 1)
		} else {
			return (topIndex.0, topIndex.1 - 1)
		}
	}

    
	func nextIndex(_ topIndex: (Int, Int)) -> (Int, Int) {
		if topIndex.1 == allResults[topIndex.0].count - 1 {
			return topIndex.0 != allResults.count - 1 ? (topIndex.0 + 1, 0) : (0, 0)
		} else {
			return (topIndex.0, topIndex.1 + 1)
		}
	}

    
	func randomThreeIndex(_ topIndex: (Int, Int)) -> [(Int, Int)] {
		var results = [(Int, Int)]()

		repeat {
			let i_0 = Int(arc4random_uniform(UInt32(allResults.count)))
			let i_1 = Int(arc4random_uniform(UInt32(allResults[i_0].count)))
			if i_0 != topIndex.0 && i_1 != topIndex.1 {
				results.append((i_0, i_1))
			}
		} while results.count < 3

		randomPreviousIndex = results[0]
		randomNextIndex = results[2]

		return results
	}

	
	func moveContentViewToTop() {
		switch scrolledType {
		case .up:
			if doneScroll {
				doneScroll = false
				theTopIndex = randomModel ? randomPreviousIndex : previousIndex(theTopIndex)

				contentViews[0].frame.origin = middleOrigin
				contentViews[0].transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
				contentViews[0].alpha = 1.0

				animate({
					self.contentViews[0].transform = CGAffineTransform.identity
					self.contentViews[1].frame.origin = self.bottomOrigin
					}, completion: {
						self.sendSubview(toBack: self.contentViews[1])
						self.contentViews[1].alpha = 0.0
						self.contentViews[1].frame.origin = self.topOrigin

						self.contentViews = [self.contentViews[1], self.contentViews[0], self.contentViews[2]]
						self.changeDetailForContentView(self.contentViews[0], dic: self.threeDic(self.theTopIndex)[0])
						self.changeDetailForContentView(self.contentViews[2], dic: self.threeDic(self.theTopIndex)[2])
						self.doneScroll = true
				})
			}


		case .down:
			if doneScroll {
				doneScroll = false
				theTopIndex = randomModel ? randomNextIndex : nextIndex(theTopIndex)

				hideDetailTitle(contentViews[1])
				bringSubview(toFront: contentViews[2])
				contentViews[2].alpha = 1.0

				animate({
					self.contentViews[1].alpha = 0.4
					self.contentViews[1].transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
					self.contentViews[2].frame.origin = self.middleOrigin
					}, completion: {
						self.contentViews[1].transform = CGAffineTransform.identity
						self.contentViews[1].alpha = 0.0
						self.contentViews[1].frame.origin = self.bottomOrigin

						self.contentViews = [self.contentViews[0], self.contentViews[2], self.contentViews[1]]
						self.changeDetailForContentView(self.contentViews[0], dic: self.threeDic(self.theTopIndex)[0])
						self.changeDetailForContentView(self.contentViews[2], dic: self.threeDic(self.theTopIndex)[2])
						self.doneScroll = true
				})
			}

		default:
			break
		}

	}

    
	func animate(_ animations: @escaping () -> (), completion: (() -> ())?) {
		UIView.perform(.delete, on: [], options: [], animations: {
			animations()
			}) { (_) in
				completion!()
		}
	}

    
	func changeDetailForContentView(_ contentView: UIScrollView, dic: SwiftDic) {
		if let detailView = contentView.subviews[0] as? DetailView {
			detailView.reloadDetail(dic)
		}
	}

    
	func hideDetailTitle(_ contentView: UIScrollView) {
		if let detailView = contentView.subviews[0] as? DetailView {
			detailView.titleLabel.text = ""
		}
	}

    
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    
}



extension XYScrollView: UIScrollViewDelegate {

    
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView != self {
			if scrollView.contentOffset.y > TriggerDistance {
				if scrolledType != .down { scrolledType = .down }
			} else if scrollView.contentOffset.y < -TriggerDistance {
				if scrolledType != .up { scrolledType = .up }
			} else {
				if scrolledType != .notScrollYet { scrolledType = .notScrollYet }
			}
		} else {
			if scrollView.contentOffset.x < -TriggerDistance {
				if scrolledType != .left { scrolledType = .left }
			} else if scrollView.contentOffset.x > TriggerDistance {
				if scrolledType != .right { scrolledType = .right }
			} else {
				if scrolledType != .notScrollYet { scrolledType = .notScrollYet }
			}
		}

	}

    
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		XYDelegate?.xyScrollViewWillScroll?(scrolledType, topViewIndex: topViewIndex)
		moveContentViewToTop()
//		delay(seconds: 0.3) { self.XYDelegate?.xyScrollViewDidScroll(self.scrolledType, topViewIndex: 1) }
//		XYDelegate?.xyScrollViewDidScroll(scrolledType, topViewIndex: topViewIndex)
//		scrolledType = .NotScrollYet
	}

    
}



extension XYScrollView: DetailViewDelegate {
    
    
    func shouldSpeakText(_ text: String) {
        XYDelegate?.speakText(text)
    }
    
    
}







