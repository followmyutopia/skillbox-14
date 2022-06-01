//
//  RealmTableViewCell.swift
//  Module 14
//
//  Created by Avicus Delacroix on 01.06.2022.
//

import UIKit

class RealmTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func editingDidBegin(_ sender: Any) {
        // when editing starts, show the save button
        confirmButton.isHidden = false
    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        // when editing ends, but the user did not save the data
        // hide the button and revert changes
        confirmButton.isHidden = true
        let tableView = self.superview as? UITableView
        tableView?.reloadData()
    }
    
    @IBAction func saveData(_ sender: Any) {
        // save the data and reload the table
        confirmButton.isHidden = true
        let tableView = self.superview as? UITableView
        let indexPath = tableView!.indexPath(for: self)![1]
        Persistence.shared.modifyTask(at: indexPath, name: taskTextField.text!)
        tableView?.reloadData()
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        // delete the
        let tableView = self.superview as? UITableView
        let indexPath = tableView!.indexPath(for: self)![1]
        Persistence.shared.deleteTask(at: indexPath)
        tableView?.reloadData()
    }
}
