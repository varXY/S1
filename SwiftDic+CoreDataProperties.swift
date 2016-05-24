//
//  SwiftDic+CoreDataProperties.swift
//  S1
//
//  Created by 文川术 on 5/24/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SwiftDic {

    @NSManaged var index: NSNumber?
    @NSManaged var word: String?
    @NSManaged var meaning: String?
    @NSManaged var code: String?

}
