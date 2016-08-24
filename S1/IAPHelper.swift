//
//  IAPHelper.swift
//  inappragedemo
//
//  Created by Ray Fix on 5/1/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import StoreKit


public let IAPHelperProductPurchasedNotification = "IAPHelperProductPurchasedNotification"

public typealias ProductIdentifier = String
public typealias RequestProductsCompletionHandler = (_ success: Bool, _ products: [SKProduct]) -> ()



public class IAPHelper : NSObject  {

	let productIdentifiers: Set<ProductIdentifier>
	var purchasedProductIdentifiers = Set<ProductIdentifier>()

	var productsRequest: SKProductsRequest?
	var completionHandler: RequestProductsCompletionHandler?


    
	public init(productIdentifiers: Set<ProductIdentifier>) {
		self.productIdentifiers = productIdentifiers
		super.init()
		SKPaymentQueue.default().add(self)
	}

    
	public func requestProductsWithCompletionHandler(_ handler: RequestProductsCompletionHandler) {
		completionHandler = handler
		productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
		productsRequest?.delegate = self
		productsRequest?.start()
	}

    
	public func purchaseProduct(_ product: SKProduct) {
		print("Buying \(product.productIdentifier)")
		let payment = SKPayment(product: product)
		SKPaymentQueue.default().add(payment)
	}
    
    
    public func restorePurchese() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
  
    
	public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
		return purchasedProductIdentifiers.contains(productIdentifier)
	}
  
    
	public func restoreCompletedTransactions() {
	}

    
	public class func canMakePayments() -> Bool {
		return SKPaymentQueue.canMakePayments()
	}
    
    
}



extension IAPHelper: SKProductsRequestDelegate {

    
	public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		print("Loaded list of products")
		completionHandler!(true, response.products)
		clearRequest()

		for p in response.products {
			print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
		}
	}

    
	public func request(_ request: SKRequest, didFailWithError error: Error) {
		print("Failed to load list of products.")
		completionHandler!(false, [])
		print("Error: \(error)")
		clearRequest()
	}

    
	private func clearRequest() {
		productsRequest = nil
		completionHandler = nil
	}
    
    
}



extension IAPHelper: SKPaymentTransactionObserver, UserDefaults {

    
	public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		for transaction in transactions {
			switch transaction.transactionState {
			case .purchased:
				completeTransaction(transaction)
				break
			case .failed:
				failedTransaction(transaction)
				break
			case .restored:
				restoreTransaction(transaction)
				break
			case .deferred:
				break
			case .purchasing:
				break
			}
		}
	}

    
	private func completeTransaction(_ transaction: SKPaymentTransaction) {
		print("completeTransaction...")
        donePurchese()
		provideContentForProductIdentifier(transaction.payment.productIdentifier)
		SKPaymentQueue.default().finishTransaction(transaction)
	}

    
	private func restoreTransaction(_ transaction: SKPaymentTransaction) {
		let productIdentifier = transaction.original?.payment.productIdentifier
		print("restoreTransaction... \(productIdentifier)")
        donePurchese()
		provideContentForProductIdentifier(productIdentifier!)
		SKPaymentQueue.default().restoreCompletedTransactions()
		SKPaymentQueue.default().finishTransaction(transaction)
	}

    
	private func provideContentForProductIdentifier(_ productIdentifier: String) {
		purchasedProductIdentifiers.insert(productIdentifier)
		Foundation.UserDefaults.standard.set(true, forKey: productIdentifier)
		Foundation.UserDefaults.standard.synchronize()
		NotificationCenter.default.post(name: Notification.Name(rawValue: IAPHelperProductPurchasedNotification), object: productIdentifier)
	}

    
	private func failedTransaction(_ transaction: SKPaymentTransaction) {
        print("failedTransaction...")
        NotificationCenter.default.post(name: Notification.Name(rawValue: IAPHelperProductPurchasedNotification), object: "fail")

		if (transaction.error as! NSError).code != SKError.Code.paymentCancelled.rawValue {
			print("Transaction error: \(transaction.error!)")
		}
        SKPaymentQueue.default().finishTransaction(transaction)
	}
    
    
}















