//
//  DetailViewController.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit
import AVFoundation


class DetailViewController: UIViewController, UserDefaults {

	var pointerView: PointerView!
	var xyScrollView: XYScrollView!
	var editButton: UIButton!

	var resultsOnTable: [[String]]!

	var initTopDetailIndex: (Int, Int)!

	var statusBarHidden = true
	var randomModel = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }



	override func viewDidLoad() {
		super.viewDidLoad()

		setUpBars()

		pointerView = PointerView()
		view = pointerView

		xyScrollView = XYScrollView(allResult: resultsOnTable, topDetailIndex: initTopDetailIndex, random: randomModel)
		xyScrollView.XYDelegate = self
		view.addSubview(xyScrollView)
        
		editButton = UIButton(type: .system)
		editButton.frame = CGRect(x: ScreenWidth - 42, y: 12, width: 30, height: 30)
		editButton.tintColor = UIColor.white
		editButton.setImage(UIImage(named: "EditIcon"), for: UIControlState())
		editButton.addTarget(self, action: #selector(editButtonTouchDown), for: .touchDown)
		editButton.addTarget(self, action: #selector(editButtonTouchUpOutside), for: .touchUpOutside)
		editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
		editButton.isExclusiveTouch = true
		view.addSubview(editButton)
    }

    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		statusBarHidden = true
		setNeedsStatusBarAppearanceUpdate()
		navigationController?.setToolbarHidden(false, animated: true)
	}

    
	func setUpBars() {
		navigationController?.isNavigationBarHidden = true
		navigationController?.toolbar.tintColor = UIColor.plainWhite

		let buttons = toolbarCustomButtons()
		buttons[0].addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
		buttons[1].addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
		buttons[2].addTarget(self, action: #selector(priviousButtonTapped), for: .touchUpInside)

		let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

		setToolbarItems([UIBarButtonItem(customView: buttons[0]), space, space, space, UIBarButtonItem(customView: buttons[1]), UIBarButtonItem(customView: buttons[2])], animated: true)
		let rect = CGRect(x: 0, y: 0, width: ScreenWidth, height: 49)
		navigationController?.toolbar.setBackgroundImage(UIImage.imageWithColor(UIColor.clear, rect: rect), forToolbarPosition: .any, barMetrics: .default)
		navigationController?.toolbar.setShadowImage(UIImage.imageWithColor(UIColor.clear, rect: CGRect(x: 0, y: 0, width: 10, height: 10)), forToolbarPosition: .any)
	}

    
	func toolbarCustomButtons() -> [UIButton] {
		let transforms = [
			CGAffineTransform(rotationAngle: CGFloat(90 * M_PI / 180)),
			CGAffineTransform(rotationAngle: CGFloat(0 * M_PI / 180)),
			CGAffineTransform(rotationAngle: CGFloat(180 * M_PI / 180))
		]

		let buttons: [UIButton] = transforms.map({
			let button = UIButton(type: .system)
			button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
			button.setImage(UIImage(named: "DirectionIcon")!, for: UIControlState())
			button.transform = $0
			button.tintColor = UIColor.white

			button.isExclusiveTouch = true
			return button
		})

		return buttons
	}

    
	func editButtonTouchDown() {
		xyScrollView.isUserInteractionEnabled = false
	}

    
	func editButtonTouchUpOutside() {
		xyScrollView.isUserInteractionEnabled = true
	}

    
	func editButtonTapped() {
        if isPurchesed() {
            let newWordVC = NewWordViewController()
            newWordVC.statusBarStyle = .default
            newWordVC.dicForEditing = xyScrollView.dicFromIndex(xyScrollView.theTopIndex)
            newWordVC.delegate = self
            present(NavigationController(rootViewController: newWordVC), animated: true, completion: nil)
        } else {
            present(NavigationController(rootViewController: BuyViewController()), animated: true, completion: nil)
        }
        
        xyScrollView.isUserInteractionEnabled = true
		
	}

    
	func backButtonTapped() {
		let _ = navigationController?.popViewController(animated: true)
	}

    
	func nextButtonTapped() {
		xyScrollView.scrolledType = .down
		xyScrollViewWillScroll(.down, topViewIndex: 1)
		xyScrollView.moveContentViewToTop()
	}

    
	func priviousButtonTapped() {
		xyScrollView.scrolledType = .up
		xyScrollViewWillScroll(.up, topViewIndex: 1)
		xyScrollView.moveContentViewToTop()
	}
    
    
}



extension DetailViewController: XYScrollViewDelegate {

    
	func scrollTypeDidChange(_ type: XYScrollType) {
		pointerView.showPointer(type)
	}

    
	func xyScrollViewWillScroll(_ scrollType: XYScrollType, topViewIndex: Int) {
		pointerView.hidePointersAndLabels()

		switch scrollType {
		case .left:
			editButton.alpha = 0.0
			let _ = navigationController?.popViewController(animated: true)
		case .right:
            delay(seconds: 0.5, completion: { self.changeModelAndShowHudView() })
		default:
			break
		}
	}

    
	func xyScrollViewDidScroll(_ scrollType: XYScrollType, topViewIndex: Int) {
	}
    
    
    func changeModelAndShowHudView() {
        randomModel = !randomModel
        xyScrollView.randomModel = randomModel
        let hudView = HudView.hudInView(view, animated: true)
        hudView.text = randomModel ? "随机模式" : "顺序模式"
        pointerView.changeRightLabelTextForRandomModel(randomModel)
    }
    
    
    func speakText(_ text: String) {
        if isPurchesed() {
            let synthesizer = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.speak(utterance)
        } else {
            present(NavigationController(rootViewController: BuyViewController()), animated: true, completion: nil)
        }
        
    }
    
    
}



extension DetailViewController: NewWordViewControllerDelegate {

    
	func didSaveNewWord() {
	}

    
	func doneEditingSwiftDic(_ dic: SwiftDic) {
		xyScrollView.changeDetailForContentView(xyScrollView.contentViews[1], dic: dic)
	}
    
    
}
