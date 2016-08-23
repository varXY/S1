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
        view.backgroundColor = UIColor.backgroundBlack
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 60, height: 44))
        titleLabel.textColor = UIColor.commentGreen
        titleLabel.font = UIFont.defaultFont(17)
        titleLabel.text = "// 解锁全部功能.swift"
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleItem
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(quit))
        navigationItem.rightBarButtonItem = cancelButton
        
        let label = UILabel(frame: CGRect(x: 0, y: ScreenHeight / 2 - 70, width: ScreenWidth, height: 70))
        label.textAlignment = .center
        label.textColor = UIColor.stringRed
        label.text = "一次性解锁添加、编辑、朗读单词功能"
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        
        print(canMakePayment())
        if canMakePayment() {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: 100, y: label.frame.origin.y + label.frame.height, width: ScreenWidth - 200, height: 50)
            button.setTitle("¥12.00", for: UIControlState())
            button.tintColor = UIColor.statementYellow
            button.layer.cornerRadius = 5.0
            button.layer.borderColor = UIColor.backgroundBlack_light.cgColor
            button.layer.borderWidth = 2.0
            button.addTarget(self, action: #selector(buy), for: .touchUpInside)
            view.addSubview(button)
            
            let r_button = UIButton(type: .system)
            r_button.frame = CGRect(x: 100, y: ScreenHeight - 60, width: ScreenWidth - 200, height: 50)
            r_button.setTitle("恢复购买", for: UIControlState())
            r_button.tintColor = UIColor(red: 150/255, green: 153/255, blue: 172/255, alpha: 1.0)
            r_button.addTarget(self, action: #selector(restore), for: .touchUpInside)
            view.addSubview(r_button)
            
            NotificationCenter.default.addObserver(self, selector: #selector(donePurcheseAndQuit(_:)), name: NSNotification.Name(rawValue: IAPHelperProductPurchasedNotification), object: nil)
        } else {
            let textLabel = UILabel(frame: CGRect(x: 0, y: label.frame.origin.y + label.frame.height, width: ScreenWidth, height: 50))
            textLabel.textAlignment = .center
            textLabel.textColor = UIColor.buildInBlue
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
    
    func donePurcheseAndQuit(_ notification: Notification) {
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
        dismiss(animated: true, completion: nil)
    }
}
