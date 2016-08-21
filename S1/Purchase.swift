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
	func purchaseProduct(_ product: SKProduct)
	func productPurchased(_ notification: Notification)
}

extension Purchase where Self: BuyViewController {

	func connectToStore() {
		let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		indicator.startAnimating()
		indicator.frame = self.view.bounds
		UIView.animate(withDuration: 0.3, animations: { indicator.backgroundColor = UIColor(red: 45/255, green: 47/255, blue: 56/255, alpha: 0.45) })
		view.addSubview(indicator)
		view.isUserInteractionEnabled = false

		SupportProducts.store.requestProductsWithCompletionHandler({ (success, products) -> () in
			indicator.removeFromSuperview()
			self.view.isUserInteractionEnabled = true
			if success {
                self.purchaseProduct(products[0])

			} else {
				let title = NSLocalizedString("连接失败", comment: "SettingVC")
				let message = NSLocalizedString("请检查你的网络连接后重试", comment: "SettingVC")
				let ok = NSLocalizedString("确定", comment: "SettingVC")
				let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
				let action = UIAlertAction(title: ok, style: .default, handler: nil)
				alertController.addAction(action)
				self.present(alertController, animated: true, completion: nil)
			}
		})
	}
    
    func canMakePayment() -> Bool {
        return IAPHelper.canMakePayments()
    }

	func purchaseProduct(_ product: SKProduct) {
        SupportProducts.store.purchaseProduct(product)
	}
    
    func restorePurchesedProduct() {
        SupportProducts.store.restorePurchese()
    }

	func productPurchased(_ notification: Notification) {
        print(#function)
	}
}
