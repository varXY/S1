//
//  Purchase.swift
//  30ZF
//
//  Created by 文川术 on 4/28/16.
//  Copyright © 2016 myname. All rights reserved.
//

import UIKit
import StoreKit

protocol Purchase: UserDefaults {
	func connectToStore()
	func purchaseProduct(product: SKProduct)
	func productPurchased(notification: NSNotification)
}

extension Purchase where Self: BuyViewController {

	func connectToStore() {
		let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
		indicator.startAnimating()
		indicator.frame = self.view.bounds
		UIView.animateWithDuration(0.3, animations: { indicator.backgroundColor = UIColor(red: 45/255, green: 47/255, blue: 56/255, alpha: 0.45) })
		view.addSubview(indicator)
		view.userInteractionEnabled = false

		SupportProducts.store.requestProductsWithCompletionHandler({ (success, products) -> () in
			indicator.removeFromSuperview()
			self.view.userInteractionEnabled = true
			if success {
                self.purchaseProduct(products[0])

			} else {
				let title = NSLocalizedString("连接失败", comment: "SettingVC")
				let message = NSLocalizedString("请检查你的网络连接后重试", comment: "SettingVC")
				let ok = NSLocalizedString("确定", comment: "SettingVC")
				let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
				let action = UIAlertAction(title: ok, style: .Default, handler: nil)
				alertController.addAction(action)
				self.presentViewController(alertController, animated: true, completion: nil)
			}
		})
	}
    
    func canMakePayment() -> Bool {
        return IAPHelper.canMakePayments()
    }

	func purchaseProduct(product: SKProduct) {
        SupportProducts.store.purchaseProduct(product)
	}
    
    func restorePurchesedProduct() {
        SupportProducts.store.restorePurchese()
    }

	func productPurchased(notification: NSNotification) {
        print(#function)
	}
}