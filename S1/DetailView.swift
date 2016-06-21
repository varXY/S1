//
//  DetailView.swift
//  S0
//
//  Created by 文川术 on 5/20/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit
import AVFoundation

class DetailView: UIView {

	var titleLabel: UILabel!
	var meaningLabel: UILabel!
	var exampleLabel: UILabel!

	init(swiftDic: SwiftDic) {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.backgroundBlack()
		layer.cornerRadius = globalRadius
		clipsToBounds = true
		setupLabels(swiftDic)
        
        let speechButton = UIButton(frame: titleLabel.frame)
        speechButton.addTarget(self, action: #selector(speech), forControlEvents: .TouchUpInside)
        addSubview(speechButton)
	}

	func reloadDetail(swiftDic: SwiftDic) {
        subviews.forEach({ if !$0.isKindOfClass(UIButton) { $0.removeFromSuperview() } })
		setupLabels(swiftDic)
	}

	func setupLabels(swiftDic: SwiftDic) {
		titleLabel = UILabel(frame: CGRectMake(10, 0, ScreenWidth - 50, 60))
		titleLabel.text = swiftDic.word
		titleLabel.font = UIFont.defaultFont(20)
		titleLabel.textColor = UIColor.stringRed()
		addSubview(titleLabel)

		let upCommentLabel = UILabel(frame: CGRectMake(10, titleLabel.frame.height, ScreenWidth - 20, 40))
		upCommentLabel.text = "/*"
		upCommentLabel.font = UIFont.defaultFont(17)
		upCommentLabel.textColor = UIColor.commentGreen()
		addSubview(upCommentLabel)

		meaningLabel = UILabel(frame: CGRectMake(30, upCommentLabel.frame.origin.y + upCommentLabel.frame.height, ScreenWidth - 40, 80))
		meaningLabel.numberOfLines = 0
		meaningLabel.text = swiftDic.meaning
		meaningLabel.font = findAdaptiveFontWithName("Menlo-Regular", labelText: swiftDic.meaning!, labelSize: meaningLabel.frame.size, minimumSize: 10)
		meaningLabel.textColor = UIColor.commentGreen()
		meaningLabel.sizeToFit()
		addSubview(meaningLabel)

		let downCommentLabel = UILabel(frame: CGRectMake(10, meaningLabel.frame.origin.y + meaningLabel.frame.height, ScreenWidth - 20, 40))
		downCommentLabel.text = "*/"
		downCommentLabel.font = UIFont.defaultFont(17)
		downCommentLabel.textColor = UIColor.commentGreen()
		addSubview(downCommentLabel)

		let exampleCommentLabel = UILabel(frame: CGRectMake(10, downCommentLabel.frame.origin.y + downCommentLabel.frame.height, ScreenWidth - 20, 40))
		exampleCommentLabel.text = "// MARK: 示例"
		exampleCommentLabel.font = UIFont.defaultFont(17)
		exampleCommentLabel.textColor = UIColor.commentGreen()
		addSubview(exampleCommentLabel)

		let y = exampleCommentLabel.frame.origin.y + exampleCommentLabel.frame.height + 10

		exampleLabel = UILabel(frame: CGRectMake(0, 0, ScreenWidth * 10, ScreenHeight - y - 30))
		exampleLabel.numberOfLines = 0
		exampleLabel.textColor = UIColor.plainWhite()
		exampleLabel.attributedText = stringToAttributedString(swiftDic.code!)
		exampleLabel.font = findAdaptiveFontWithName("Menlo-Regular", labelText: swiftDic.code!, labelSize: exampleLabel.frame.size, minimumSize: 10)
		exampleLabel.sizeToFit()

		let scrollView = UIScrollView(frame: CGRectMake(10, y, ScreenWidth - 10, exampleLabel.frame.height + 10))
		scrollView.contentSize = CGSizeMake(exampleLabel.frame.width + 10, 0)
		scrollView.addSubview(exampleLabel)

		addSubview(scrollView)
	}
    
    func speech() {
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: titleLabel.text!)
//        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speakUtterance(utterance)
    }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
