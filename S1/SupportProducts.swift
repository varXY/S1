//
//  SupportProducts.swift
//  P3
//
//  Created by 文川术 on 2/23/16.
//  Copyright © 2016 myname. All rights reserved.
//

import Foundation


public enum SupportProducts {

	private static let Prefix = "xiaoyao.com.SwiftDict."

	public static let SupportOne = Prefix + "SupportOne"

	private static let productIdentifiers: Set<ProductIdentifier> = [
		SupportProducts.SupportOne,
		]

	public static let store = IAPHelper(productIdentifiers: SupportProducts.productIdentifiers)
}


func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
	return productIdentifier.components(separatedBy: ".").last
}
