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
    
    init() {
        self.tasks = fetchTasks()
    }
    
    var mockTask: [Task] {
        let task1 = Task(name: "Walk around", notes: "Close them rings", due: Date(timeIntervalSinceNow: 20000))
        let task2 = Task(name: "Eat some cookies", notes: "Enjoy!", due: Date(timeIntervalSinceNow: 26000))
        let task3 = Task(name: "Play Some games", notes: "What game will you play", due: Date(timeIntervalSinceNow: 30000))
        return [task1, task2, task3]
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
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    func toggleView(task: Task) {
        task.isComplete.toggle()
        
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
