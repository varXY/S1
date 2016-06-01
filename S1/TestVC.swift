//
//  TestVC.swift
//  S1
//
//  Created by 文川术 on 6/1/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

typealias simpleFuncion = () -> ()

extension UIContentContainer where Self: UIViewController {

}

prefix operator  ^ {}

prefix func ^ (vector: Double) -> Double {
	return pow(2, vector)
}

struct Secret {
	private let salary = 0

	private func howToMakeMyselfHappy() {

	}
}


class TestVC: UIViewController {



	override func viewDidLoad() {
		super.viewDidLoad()

		var a: Int? = 10
		a = 100
		print(a) // 输出：100
		a = nil
		print(a) // 输出：nil

	}

	func getLength(string: AnyObject) -> Int? {
		guard let text = string as? NSString else { return nil }
		return text.length
	}
}
