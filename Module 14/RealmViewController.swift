//
//  RealmViewController.swift
//  Module 14
//
//  Created by Avicus Delacroix on 01.06.2022.
//

import UIKit

class RealmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
        Persistence.shared.addTask(name: "")
        tableView.reloadData()
    }
    
}

extension RealmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Persistence.shared.getTasks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RealmCell") as! RealmTableViewCell
        cell.taskTextField.text = Persistence.shared.getTasks()[indexPath.row].name
        return cell
    }
}
