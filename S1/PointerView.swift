//
//  PointerView.swift
//  D4
//
//  Created by 文川术 on 4/11/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

struct Pointer {
	let length: CGFloat = 30
	let textPointer = ["-", "+", "×", "="]

	let originCenters = [
		CGPointMake(ScreenWidth / 2, 30 / 2 - 30),
		CGPointMake(ScreenWidth / 2, ScreenHeight - (30 / 2) + 30),
		CGPointMake(30 / 2 - 30, ScreenHeight / 2),
		CGPointMake(ScreenWidth - (30 / 2) + 30, ScreenHeight / 2),
	]

	let toCenters = [
		CGPointMake(ScreenWidth / 2, 30 / 2 + 5),
		CGPointMake(ScreenWidth / 2, ScreenHeight - (30 / 2) - 6),
		CGPointMake(30 / 2 + 4.5, ScreenHeight / 2),
		CGPointMake(ScreenWidth - (30 / 2) - 4.5, ScreenHeight / 2),
	]

	func pointerLabel(type: XYScrollType) -> UILabel {
		let pointer = UILabel()
		pointer.frame.size = CGSize(width: length, height: length)
		pointer.center = toCenters[type.rawValue]
		pointer.textColor = UIColor.stringRed()
		pointer.text = textPointer[type.rawValue]
		pointer.textAlignment = .Center
		pointer.font = UIFont.defaultFont(19)
		return pointer
	}
}

class PointerView: UIView {

	var pointers = [UILabel]()
	var UDLR_labels = [UILabel]()
	var blankViews: [UIView]!

	var lastUpdateText: String! {
		didSet {
			self.UDLR_labels[0].text = lastUpdateText
		}
	}

	struct Label {
		let UD_size = CGSize(width: ScreenWidth - 30 * 2, height: 30)
		let LR_size = CGSize(width: 30, height: ScreenHeight - 30 * 4)
		let texts = ["前一个", "后一个", "返\n回", "随\n机\n浏\n览"]
		func label(type: XYScrollType) -> UILabel {
			let label = UILabel()
			label.backgroundColor = UIColor.clearColor()
			label.textAlignment = .Center
			label.textColor = UIColor.statementYellow()
			label.font = UIFont.defaultFont(15)
			label.text = texts[type.rawValue]

			switch type {
			case .Up:
				label.frame.origin = CGPoint(x: 30, y: 30)
				label.frame.size = UD_size
			case .Down:
				label.frame.origin = CGPoint(x: 30, y: ScreenHeight - 60)
				label.frame.size = UD_size
			case .Left:
				label.frame.origin = CGPoint(x: 30, y: 60)
				label.frame.size = LR_size
				label.numberOfLines = 0
			case .Right:
				label.frame.origin = CGPoint(x: ScreenWidth - 60, y: 60)
				label.frame.size = LR_size
				label.numberOfLines = 0
			default:
				break
			}

			return label
		}
	}

	let pointer = Pointer()
	var canHide = true

	init() {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.backgroundBlack_light()
		layer.cornerRadius = globalRadius
		clipsToBounds = true
		tintColor = UIColor.whiteColor()

		let types = [XYScrollType.Up, XYScrollType.Down, XYScrollType.Left, XYScrollType.Right]
		pointers = types.map({ pointer.pointerLabel($0) })
		pointers.forEach({ $0.alpha = 0.0; addSubview($0) })

		UDLR_labels = types.map({ Label().label($0) })
		UDLR_labels.forEach({ $0.alpha = 0.0; addSubview($0) })

	}

	func showPointer(type: XYScrollType) {
		switch type {
		case .Up, .Down, .Left, .Right:
//			canHide = false
			moveAndDone({
				self.pointers[type.rawValue].alpha = 1.0
				self.UDLR_labels[type.rawValue].alpha = 1.0
//				self.pointers[type.rawValue].center = self.pointer.toCenters[type.rawValue]
				}, done: {
//					self.canHide = true
			})
//			move({
//				self.pointers[type.rawValue].alpha = 1.0
//				self.UDLR_labels[type.rawValue].alpha = 1.0
//				self.pointers[type.rawValue].center = self.pointer.toCenters[type.rawValue]
//			})
		default:
			hidePointersAndLabels()
		}
	}

	func moveAndDone(move: () -> (), done: () -> ()) {
		UIView.performSystemAnimation(.Delete, onViews: [], options: [], animations: { 
			move()
			}) { (compelete) in
				done()
		}
	}

	func move(animate: () -> ()) {
		UIView.performSystemAnimation(.Delete, onViews: [], options: [], animations: { 
			animate()
			}, completion: nil)
	}

	func hidePointersAndLabels() {
			pointers.forEach({
				if $0.alpha == 1.0 { $0.alpha = 0.0 }
//				let i = pointers.indexOf($0)!
//				if $0.center == self.pointer.toCenters[i] {
//					$0.center = self.pointer.originCenters[i]
//				}
			})

			UDLR_labels.forEach({ if $0.alpha == 1.0 { $0.alpha = 0.0 } })
	}

	func changeRightLabelTextForRandomModel(random: Bool) {
		UDLR_labels[3].text = random ? "顺\n序\n浏\n览" : "随\n机\n浏\n览"
	}
	

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}