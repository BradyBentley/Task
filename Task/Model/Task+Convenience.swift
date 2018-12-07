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
    
    @discardableResult
    convenience init(name: String, notes: String? = nil, due: Date = Date(), isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.name = name
        self.due = due
        self.notes = notes
        self.isComplete = false
    }
}

