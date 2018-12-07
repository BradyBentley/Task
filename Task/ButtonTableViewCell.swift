//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Brady Bentley on 12/5/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var primaryLabel: UILabel!
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var completeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    func updateButton(_ isComplete: Bool) {
        let buttonImage = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: buttonImage), for: .normal)
    }
}

extension ButtonTableViewCell {
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}

protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}
