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
		CGPoint(x: ScreenWidth / 2, y: 30 / 2 - 30),
		CGPoint(x: ScreenWidth / 2, y: ScreenHeight - (30 / 2) + 30),
		CGPoint(x: 30 / 2 - 30, y: ScreenHeight / 2),
		CGPoint(x: ScreenWidth - (30 / 2) + 30, y: ScreenHeight / 2),
	]

	let toCenters = [
		CGPoint(x: ScreenWidth / 2, y: 30 / 2 + 5),
		CGPoint(x: ScreenWidth / 2, y: ScreenHeight - (30 / 2) - 6),
		CGPoint(x: 30 / 2 + 4.5, y: ScreenHeight / 2),
		CGPoint(x: ScreenWidth - (30 / 2) - 4.5, y: ScreenHeight / 2),
	]

	func pointerLabel(_ type: XYScrollType) -> UILabel {
		let pointer = UILabel()
		pointer.frame.size = CGSize(width: length, height: length)
		pointer.center = toCenters[type.rawValue]
		pointer.textColor = UIColor.stringRed()
		pointer.text = textPointer[type.rawValue]
		pointer.textAlignment = .center
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
		func label(_ type: XYScrollType) -> UILabel {
			let label = UILabel()
			label.backgroundColor = UIColor.clear
			label.textAlignment = .center
			label.textColor = UIColor.statementYellow()
			label.font = UIFont.defaultFont(15)
			label.text = texts[type.rawValue]

			switch type {
			case .up:
				label.frame.origin = CGPoint(x: 30, y: 30)
				label.frame.size = UD_size
			case .down:
				label.frame.origin = CGPoint(x: 30, y: ScreenHeight - 60)
				label.frame.size = UD_size
			case .left:
				label.frame.origin = CGPoint(x: 30, y: 60)
				label.frame.size = LR_size
				label.numberOfLines = 0
			case .right:
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
		tintColor = UIColor.white

		let types = [XYScrollType.up, XYScrollType.down, XYScrollType.left, XYScrollType.right]
		pointers = types.map({ pointer.pointerLabel($0) })
		pointers.forEach({ $0.alpha = 0.0; addSubview($0) })

		UDLR_labels = types.map({ Label().label($0) })
		UDLR_labels.forEach({ $0.alpha = 0.0; addSubview($0) })

	}

	func showPointer(_ type: XYScrollType) {
		switch type {
		case .up, .down, .left, .right:
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

	func moveAndDone(_ move: @escaping () -> (), done: @escaping () -> ()) {
		UIView.perform(.delete, on: [], options: [], animations: { 
			move()
			}) { (compelete) in
				done()
		}
	}

	func move(_ animate: @escaping () -> ()) {
		UIView.perform(.delete, on: [], options: [], animations: { 
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

	func changeRightLabelTextForRandomModel(_ random: Bool) {
		UDLR_labels[3].text = random ? "顺\n序\n浏\n览" : "随\n机\n浏\n览"
	}
	

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
