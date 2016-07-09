//
//  BuyViewController.swift
//  S1
//
//  Created by yao xiao on 7/9/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, Purchase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundBlack()
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, ScreenWidth - 60, 44))
        titleLabel.textColor = UIColor.commentGreen()
        titleLabel.font = UIFont.defaultFont(17)
        titleLabel.text = "// 解锁全部功能.swift"
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleItem
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(quit))
        navigationItem.rightBarButtonItem = cancelButton
        
        let label = UILabel(frame: CGRectMake(0, ScreenHeight / 2 - 70, ScreenWidth, 70))
        label.textAlignment = .Center
        label.textColor = UIColor.stringRed()
        label.text = "一次性解锁添加、编辑、朗读单词功能"
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        
        let button = UIButton(type: .System)
        button.frame = CGRectMake(100, label.frame.origin.y + label.frame.height, ScreenWidth - 200, 50)
        button.setTitle("¥12.00", forState: .Normal)
        button.tintColor = UIColor.statementYellow()
        button.layer.cornerRadius = 5.0
        button.layer.borderColor = UIColor.backgroundBlack_light().CGColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(buy), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(quit), name: IAPHelperProductPurchasedNotification, object: nil)
        
    }
    
    func buy() {
        connectToStore()
    }
    
    func quit() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
