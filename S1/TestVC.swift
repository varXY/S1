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


class tableViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = UIColor.clearColor()
		tableView.separatorStyle = .None
		tableView.sectionIndexColor = UIColor.whiteColor()
		tableView.sectionIndexBackgroundColor = UIColor.clearColor()
	}
}
