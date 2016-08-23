//
//  AppDelegate.swift
//  S1
//
//  Created by 文川术 on 5/24/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {

    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.backgroundBlack()
        
        let mainVC = MainViewController()
        window?.rootViewController = NavigationController(rootViewController: mainVC)
        window?.makeKeyAndVisible()
        
        return true
    }

	private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.backgroundColor = UIColor.backgroundBlack()

		let mainVC = MainViewController()
		window?.rootViewController = NavigationController(rootViewController: mainVC)
		window?.makeKeyAndVisible()

		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
	}

	func applicationWillTerminate(_ application: UIApplication) {
		self.saveContext()
	}

	// MARK: - Core Data stack

	lazy var applicationDocumentsDirectory: URL = {
	    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
	    return urls[urls.count-1]
	}()

	lazy var managedObjectModel: NSManagedObjectModel = {
	    let modelURL = Bundle.main.url(forResource: "S1", withExtension: "momd")!
	    return NSManagedObjectModel(contentsOf: modelURL)!
	}()

	lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
	    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
	    let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
	    var failureReason = "There was an error creating or loading the application's saved data."
	    do {
	        try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
	    } catch {
	        var dict = [String: AnyObject]()
	        dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
	        dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject

	        dict[NSUnderlyingErrorKey] = error as NSError
	        let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
	        NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
	        abort()
	    }
	    
	    return coordinator
	}()

	lazy var managedObjectContext: NSManagedObjectContext = {
	    let coordinator = self.persistentStoreCoordinator
	    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
	    managedObjectContext.persistentStoreCoordinator = coordinator
	    return managedObjectContext
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
	    if managedObjectContext.hasChanges {
	        do {
	            try managedObjectContext.save()
	        } catch {
	            let nserror = error as NSError
	            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
	            abort()
	        }
	    }
	}

}

