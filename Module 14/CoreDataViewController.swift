//
//  CoreDataViewController.swift
//  Module 14
//
//  Created by Avicus Delacroix on 01.06.2022.
//

import UIKit

class CoreDataViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Persistence.shared.coreDataFetch()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
        Persistence.shared.coreDataAddTask(name: "")
        tableView.reloadData()
    }
}

extension CoreDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Persistence.shared.coreDataTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreDataCell") as! CoreDataTableViewCell
        cell.taskTextField.text = Persistence.shared.coreDataTasks[indexPath.row].value(forKeyPath: "name") as? String
        return cell
    }
}
