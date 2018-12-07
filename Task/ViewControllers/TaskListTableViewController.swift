//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Brady Bentley on 12/6/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate, NSFetchedResultsControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
        tableView.reloadData()
        

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.shared.fetchedResultsController.sections?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = TaskController.shared.fetchedResultsController.sections else { fatalError("No sections in fetchedResultsController") }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? ButtonTableViewCell else { fatalError() }
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        cell.delegate = self
        cell.update(withTask: task)
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = TaskController.shared.fetchedResultsController.sections?[section] else { return nil }
        switch sectionInfo.name {
        case "0":
            return "Incomplete"
        case "1":
            return "Complete"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            TaskController.shared.remove(task: task)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "ToTaskDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destinationVC = segue.destination as? TaskDetailTableViewController
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            destinationVC?.task = task
            destinationVC?.task?.due = task.due
        }
    }

    // MARK: - ButtonTableViewCellDelegate
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        TaskController.shared.toggleView(task: task)
    }
    

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type{
            
        case .delete:
            // Delete code here
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            // Insert code here
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .move:
            // Move code here
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        case.update:
            // Update code here
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .delete:
            tableView.deleteSections([sectionIndex], with: .fade)
        case .insert:
            tableView.insertSections([sectionIndex], with: .fade)
        case .update:
            tableView.reloadSections([sectionIndex], with: .fade)
        case .move:
            tableView.moveSection(sectionIndex, toSection: sectionIndex)
        }
    }

}
