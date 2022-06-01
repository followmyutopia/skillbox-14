//
//  CoreDataTableViewCell.swift
//  Module 14
//
//  Created by Avicus Delacroix on 01.06.2022.
//

import UIKit

class CoreDataTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func editingDidEnd(_ sender: Any) {
        // when editing ends, but the user did not save the data
        // hide the button and revert changes
        confirmButton.isHidden = true
        let tableView = self.superview as? UITableView
        tableView?.reloadData()
    }
    
    @IBAction func editingDidBegin(_ sender: Any) {
        // when editing starts, show the save button
        confirmButton.isHidden = false
    }
    
    @IBAction func saveData(_ sender: Any) {
        // save the data and reload the table
        confirmButton.isHidden = true
        let tableView = self.superview as? UITableView
        let indexPath = tableView!.indexPath(for: self)![1]
        Persistence.shared.coreDataModifyTask(at: indexPath, name: taskTextField.text!)
        tableView?.reloadData()
    }
    @IBAction func deleteTask(_ sender: Any) {
        // delete the current task and reload the table
        let tableView = self.superview as? UITableView
        let indexPath = tableView!.indexPath(for: self)![1]
        Persistence.shared.coreDataDeleteTask(at: indexPath)
        tableView?.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
