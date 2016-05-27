//
//  SwiftDicData.swift
//  S1
//
//  Created by 文川术 on 5/24/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol SwiftDicData {
	var appDelegate: UIApplicationDelegate { get }
	var managedContext: NSManagedObjectContext { get }
	
	func wordsFromSection(section: Int) -> [String]
	func detailOfWord(word: String) -> SwiftDic?

	func saveSwiftDic(swiftDic: SwiftDic)
	func editSwiftDic(word: String, edited: (SwiftDic) -> (SwiftDic))
}

extension SwiftDicData {

	var appDelegate: UIApplicationDelegate {
		return UIApplication.sharedApplication().delegate as! AppDelegate
	}

	var managedContext: NSManagedObjectContext {
		return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
	}

	func wordsFromSection(section: Int) -> [String] {
		var words = [String]()

		let fetchRequest = NSFetchRequest(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entityForName("SwiftDic", inManagedObjectContext: managedContext)
		fetchRequest.predicate = NSPredicate(format: "index == %f", Double(section))

		do {
			if let dics = try managedContext.executeFetchRequest(fetchRequest) as? [SwiftDic] {
				words = dics.map({ $0.word! })
			}
		} catch {
			print("can't get words")
		}

		if words.count == 0 { words = [""] }
		return words.sort({ $0 < $1 })
	}

	func detailOfWord(word: String) -> SwiftDic? {
		var swiftDic: SwiftDic?

		let fetchRequest = NSFetchRequest(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entityForName("SwiftDic", inManagedObjectContext: managedContext)
		fetchRequest.predicate = NSPredicate(format: "word == %@", word)

		do {
			if let dics = try managedContext.executeFetchRequest(fetchRequest) as? [SwiftDic] {
				swiftDic = dics.count == 0 ? nil : dics[0]
			}
		} catch {
			print("can't get word's detail")
		}

		return swiftDic
	}

	func saveSwiftDic(swiftDic: SwiftDic) {
		let entity = NSEntityDescription.entityForName("SwiftDic", inManagedObjectContext: managedContext)
		let dic = SwiftDic(entity: entity!, insertIntoManagedObjectContext: managedContext)
		dic.index = swiftDic.index
		dic.word = swiftDic.word
		dic.meaning = swiftDic.meaning
		dic.code = swiftDic.code

		do {
			try managedContext.save()
		} catch {
			print("can't save")
		}
	}

	func editSwiftDic(word: String, edited: (SwiftDic) -> (SwiftDic)) {
		let fetchRequest = NSFetchRequest(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entityForName("SwiftDic", inManagedObjectContext: managedContext)
		fetchRequest.predicate = NSPredicate(format: "word == %@", word)

		do {
			if let dics = try managedContext.executeFetchRequest(fetchRequest) as? [SwiftDic] {
				let newDic = edited(dics[0])
				dics[0].index = newDic.index
				dics[0].word = newDic.word
				dics[0].meaning = newDic.meaning
				dics[0].code = newDic.code
			}
		} catch {
			print("can't get word's detail")
		}

		do {
			try managedContext.save()
			print("dic edited")
		} catch {
			print("can't edited dic")
		}
	}

}