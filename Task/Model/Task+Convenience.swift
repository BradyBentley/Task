//
//  Task+Convenience.swift
//  Task
//
//  Created by Brady Bentley on 12/5/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    convenience init(name: String, notes: String, due: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.name = name
    }
}
