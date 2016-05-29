//
//  SwiftDicData_1.swift
//  S1
//
//  Created by 文川术 on 5/29/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit
import CoreData


protocol SwiftDicData_1 {
	var appDelegate_1: UIApplicationDelegate { get }
	var managedContext_1: NSManagedObjectContext { get }

	func preloadedSwiftDics() -> [SwiftDic]
	func saveAsPreloadedSwiftDics(dics: [SwiftDic])
}

extension SwiftDicData_1 {

	var appDelegate_1: UIApplicationDelegate {
		return UIApplication.sharedApplication().delegate as! AppDelegate
	}

	var managedContext_1: NSManagedObjectContext {
		return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext_1
	}

	func preloadedSwiftDics() -> [SwiftDic] {
		var swiftDics = [SwiftDic]()

		let fetchRequest = NSFetchRequest(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entityForName("SwiftDic", inManagedObjectContext: managedContext_1)

		do {
			if let dics = try managedContext_1.executeFetchRequest(fetchRequest) as? [SwiftDic] {
				swiftDics = dics
			}
		} catch {
			print("can't get preloaded dics")
		}

		return swiftDics
	}

	func saveAsPreloadedSwiftDics(dics: [SwiftDic]) {
		let fetchRequest = NSFetchRequest(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entityForName("SwiftDic", inManagedObjectContext: managedContext_1)

		do {
			let oldDics = try managedContext_1.executeFetchRequest(fetchRequest)
			if oldDics.count != 0 {
				oldDics.forEach({ managedContext_1.deleteObject($0 as! NSManagedObject) })
			}
		} catch {
			print("can't get old storys")
		}

		let entity = NSEntityDescription.entityForName("SwiftDic", inManagedObjectContext: managedContext_1)

		dics.forEach({
			let dic = SwiftDic(entity: entity!, insertIntoManagedObjectContext: managedContext_1)
			dic.index = $0.index
			dic.word = $0.word
			dic.meaning = $0.meaning
			dic.code = $0.code

			do {
				try managedContext_1.save()
				print("dic saved")
			} catch {
				print("can't save dic")
			}

		})
	}
}



