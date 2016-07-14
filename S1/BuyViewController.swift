//
//  BuyViewController.swift
//  S1
//
//  Created by yao xiao on 7/9/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, Purchase {
    
    var purchesed = false
    
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
        
        print(canMakePayment())
        if canMakePayment() {
            let button = UIButton(type: .System)
            button.frame = CGRectMake(100, label.frame.origin.y + label.frame.height, ScreenWidth - 200, 50)
            button.setTitle("¥12.00", forState: .Normal)
            button.tintColor = UIColor.statementYellow()
            button.layer.cornerRadius = 5.0
            button.layer.borderColor = UIColor.backgroundBlack_light().CGColor
            button.layer.borderWidth = 2.0
            button.addTarget(self, action: #selector(buy), forControlEvents: .TouchUpInside)
            view.addSubview(button)
            
            let r_button = UIButton(type: .System)
            r_button.frame = CGRectMake(100, ScreenHeight - 60, ScreenWidth - 200, 50)
            r_button.setTitle("恢复购买", forState: .Normal)
            r_button.tintColor = UIColor(red: 150/255, green: 153/255, blue: 172/255, alpha: 1.0)
            r_button.addTarget(self, action: #selector(restore), forControlEvents: .TouchUpInside)
            view.addSubview(r_button)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(donePurcheseAndQuit(_:)), name: IAPHelperProductPurchasedNotification, object: nil)
        } else {
            let textLabel = UILabel(frame: CGRectMake(0, label.frame.origin.y + label.frame.height, ScreenWidth, 50))
            textLabel.textAlignment = .Center
            textLabel.textColor = UIColor.buildInBlue()
            textLabel.text = "你的设备无法进行购买操作"
            textLabel.adjustsFontSizeToFitWidth = true
            view.addSubview(label)
        }
        
    }
    
    func buy() {
        connectToStore()
    }
    
    func restore() {
        restorePurchesedProduct()
    }
    
    func donePurcheseAndQuit(notification: NSNotification) {
        if purchesed { return }
        purchesed = true
        guard let object = notification.object as? String else { return }
        print(object)
        if object == "fail" { return }
        let hudView = HudView.hudInView(view, animated: true)
        hudView.text = "解锁成功！"
        delay(seconds: 1.0) { self.quit() }
    }
    
    func quit() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
