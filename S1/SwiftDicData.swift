//
//  SwiftDicData.swift
//  S1
//
//  Created by 文川术 on 5/24/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit
import CoreData

protocol SwiftDicData {
	var appDelegate: UIApplicationDelegate { get }
	var managedContext: NSManagedObjectContext { get }

	func allSwiftDics() -> [SwiftDic]
	func savePreloadedwords(_ completion: () -> ())

	func wordsFromSection(_ section: Int) -> [String]
	func detailOfWord(_ word: String) -> SwiftDic?

	func saveSwiftDic(_ swiftDic: SwiftDic)
	func editSwiftDic(_ word: String, edited: (SwiftDic) -> (SwiftDic))

	func deleteSwiftDic(_ word: String)
}

extension SwiftDicData {

	var appDelegate: UIApplicationDelegate {
		return UIApplication.shared.delegate as! AppDelegate
	}

	var managedContext: NSManagedObjectContext {
		return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
	}

	func allSwiftDics() -> [SwiftDic] {
		var swiftDics = [SwiftDic]()

		let fetchRequest = NSFetchRequest<SwiftDic>(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)

		do {
			let dics = try managedContext.fetch(fetchRequest)
            swiftDics = dics
			
		} catch {
			print("can't get preloaded dics")
		}

		return swiftDics
	}

	func savePreloadedwords(_ completion: () -> ()) {
		let fetchRequest = NSFetchRequest<SwiftDic>(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)

		do {
			let oldDics = try managedContext.fetch(fetchRequest)
			if oldDics.count != 0 {
				oldDics.forEach({ managedContext.delete($0 as NSManagedObject) })
			}
		} catch {
			print("can't get old storys")
		}

		let arrays = PreloadedWords().arrays
		arrays.forEach({
			let entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)
			let dic = SwiftDic(entity: entity!, insertInto: managedContext)
			dic.index = Int($0[0])! as NSNumber
			dic.word = $0[1]
			dic.meaning = $0[2]
			dic.code = $0[3]

			do {
				try managedContext.save()
			} catch {
				print("can't save")
			}
		})

		completion()
	}

	func wordsFromSection(_ section: Int) -> [String] {
		var words = [String]()

		let fetchRequest = NSFetchRequest<SwiftDic>(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)
		fetchRequest.predicate = NSPredicate(format: "index == %f", Double(section))

		do {
			let dics = try managedContext.fetch(fetchRequest)
            words = dics.map({ $0.word! })
			
		} catch {
			print("can't get words")
		}

		if words.count == 0 { words = [""] }
		return words.sorted(by: { $0 < $1 })
	}

	func detailOfWord(_ word: String) -> SwiftDic? {
		var swiftDic: SwiftDic?

		let fetchRequest = NSFetchRequest<SwiftDic>(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)
		fetchRequest.predicate = NSPredicate(format: "word == %@", word)

		do {
			let dics = try managedContext.fetch(fetchRequest)
            swiftDic = dics.count == 0 ? nil : dics[0]

		} catch {
			print("can't get word's detail")
		}

		return swiftDic
	}

	func saveSwiftDic(_ swiftDic: SwiftDic) {
		let entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)
		let dic = SwiftDic(entity: entity!, insertInto: managedContext)
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

	func editSwiftDic(_ word: String, edited: (SwiftDic) -> (SwiftDic)) {
		let fetchRequest = NSFetchRequest<SwiftDic>(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)
		fetchRequest.predicate = NSPredicate(format: "word == %@", word)

		do {
			let dics = try managedContext.fetch(fetchRequest)
            let newDic = edited(dics[0])
            dics[0].index = newDic.index
            dics[0].word = newDic.word
            dics[0].meaning = newDic.meaning
            dics[0].code = newDic.code
			
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

	func deleteSwiftDic(_ word: String) {
        // write this way may not work in deleting
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SwiftDic")
		fetchRequest.entity = NSEntityDescription.entity(forEntityName: "SwiftDic", in: managedContext)
		fetchRequest.predicate = NSPredicate(format: "word == %@", word)

		do {
			if let dics = try managedContext.fetch(fetchRequest) as? [NSManagedObject] {
				managedContext.delete(dics[0])
			}
		} catch {
			print("can't get word for deleting")
		}

		do {
			try managedContext.save()
			print("dic deleted")
		} catch {
			print("can't delete dic")
		}
	}

}
