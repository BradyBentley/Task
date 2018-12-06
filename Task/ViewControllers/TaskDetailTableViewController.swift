//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Brady Bentley on 12/5/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    var dueDateValue: Date?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet var dueDatePicker: UIDatePicker!
    

    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        dueDateTextField.inputView = dueDatePicker
    }
    
    func updateViews() {
        guard let task = task else { return }
        nameTextField?.text = task.name
        notesTextField?.text = task.notes
        dueDateTextField?.text = task.due?.stringValue()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard nameTextField.text != "", notesTextField.text != "", let name = nameTextField.text, let notes = notesTextField.text else { return }
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDateValue)
        } else {
            TaskController.shared.addTaskWithName(name: name, notes: notes, due: dueDateValue)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateAsString = dueDatePicker.date.stringValue()
        dueDateTextField.text = dateAsString
        dueDateValue = dueDatePicker.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        notesTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    

}

