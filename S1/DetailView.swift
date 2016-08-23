//
//  DetailView.swift
//  S0
//
//  Created by 文川术 on 5/20/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

protocol DetailViewDelegate: class{
    func shouldSpeakText(_ text: String)
}

class DetailView: UIView, UserDefaults {

	var titleLabel: UILabel!
	var meaningLabel: UILabel!
	var exampleLabel: UILabel!
    
    weak var delegate: DetailViewDelegate?

	init(swiftDic: SwiftDic) {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.backgroundBlack
		layer.cornerRadius = globalRadius
		clipsToBounds = true
		setupLabels(swiftDic)
        
        let speechButton = UIButton(frame: titleLabel.frame)
        speechButton.addTarget(self, action: #selector(speak), for: .touchUpInside)
        addSubview(speechButton)
	}

	func reloadDetail(_ swiftDic: SwiftDic) {
        subviews.forEach({ if !$0.isKind(of: UIButton.self) { $0.removeFromSuperview() } })
		setupLabels(swiftDic)
	}

	func setupLabels(_ swiftDic: SwiftDic) {
		titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: ScreenWidth - 50, height: 60))
		titleLabel.text = swiftDic.word
		titleLabel.font = UIFont.defaultFont(20)
		titleLabel.textColor = UIColor.stringRed
		addSubview(titleLabel)

		let upCommentLabel = UILabel(frame: CGRect(x: 10, y: titleLabel.frame.height, width: ScreenWidth - 20, height: 40))
		upCommentLabel.text = "/*"
		upCommentLabel.font = UIFont.defaultFont(17)
		upCommentLabel.textColor = UIColor.commentGreen
		addSubview(upCommentLabel)

		meaningLabel = UILabel(frame: CGRect(x: 30, y: upCommentLabel.frame.origin.y + upCommentLabel.frame.height, width: ScreenWidth - 40, height: 80))
		meaningLabel.numberOfLines = 0
		meaningLabel.text = swiftDic.meaning
		meaningLabel.font = findAdaptiveFontWithName("Menlo-Regular", labelText: swiftDic.meaning!, labelSize: meaningLabel.frame.size, minimumSize: 10)
		meaningLabel.textColor = UIColor.commentGreen
		meaningLabel.sizeToFit()
		addSubview(meaningLabel)

		let downCommentLabel = UILabel(frame: CGRect(x: 10, y: meaningLabel.frame.origin.y + meaningLabel.frame.height, width: ScreenWidth - 20, height: 40))
		downCommentLabel.text = "*/"
		downCommentLabel.font = UIFont.defaultFont(17)
		downCommentLabel.textColor = UIColor.commentGreen
		addSubview(downCommentLabel)

		let exampleCommentLabel = UILabel(frame: CGRect(x: 10, y: downCommentLabel.frame.origin.y + downCommentLabel.frame.height, width: ScreenWidth - 20, height: 40))
		exampleCommentLabel.text = "// MARK: 示例"
		exampleCommentLabel.font = UIFont.defaultFont(17)
		exampleCommentLabel.textColor = UIColor.commentGreen
		addSubview(exampleCommentLabel)

		let y = exampleCommentLabel.frame.origin.y + exampleCommentLabel.frame.height + 10

		exampleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth * 10, height: ScreenHeight - y - 30))
		exampleLabel.numberOfLines = 0
		exampleLabel.textColor = UIColor.plainWhite
		exampleLabel.attributedText = stringToAttributedString(swiftDic.code!)
		exampleLabel.font = findAdaptiveFontWithName("Menlo-Regular", labelText: swiftDic.code!, labelSize: exampleLabel.frame.size, minimumSize: 10)
		exampleLabel.sizeToFit()

		let scrollView = UIScrollView(frame: CGRect(x: 10, y: y, width: ScreenWidth - 10, height: exampleLabel.frame.height + 10))
		scrollView.contentSize = CGSize(width: exampleLabel.frame.width + 10, height: 0)
		scrollView.addSubview(exampleLabel)

		addSubview(scrollView)
	}
    
    func speak() {
        delegate?.shouldSpeakText(titleLabel.text!)
    }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
