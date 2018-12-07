//
//  TaskController.swift
//  Task
//
//  Created by Brady Bentley on 12/5/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    // MARK: - Properties
    //Shared instance
    static let shared = TaskController()
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true)]
        request.sortDescriptors = [NSSortDescriptor(key: "due", ascending: true)]
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    init () {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error in \(#function) : \(error.localizedDescription)")
        }
    }
    
    // MARK: - CRUD
    
    //Create
    func addTaskWithName(name: String, notes: String?, due: Date?) {
        let _ = Task(name: name, notes: notes ?? "", due: due ?? Date())
        saveToPersistentStore()
        
    }
    
    //Update
    func update(task: Task, name: String, notes: String?, due: Date?) {
        Task(name: name, notes: notes ?? "", due: due ?? Date())
        saveToPersistentStore()
    }
    
    //Delete
    func remove(task: Task){
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
    }
    
    func toggleView(task: Task) {
        task.isComplete.toggle()
        saveToPersistentStore()
        
    }
    
    // MARK: - Persistent
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error saving your tasks; \(error.localizedDescription)")
        }
        
    }
    
}
