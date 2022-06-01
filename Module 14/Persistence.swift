//
//  Persistence.swift
//  Module 14
//
//  Created by Avicus Delacroix on 01.06.2022.
//

import Foundation
import RealmSwift
import CoreData

class TodoTask: Object {
    @Persisted var name: String = ""
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

class Persistence {
    static let shared = Persistence()

    // UserDefaults
    
    private let kFirstNameKey = "Persistence.kFirstNameKey"
    var firstName: String? {
        set { Foundation.UserDefaults.standard.set(newValue, forKey: kFirstNameKey) }
        get { return Foundation.UserDefaults.standard.string(forKey: kFirstNameKey) }
    }
    
    private let kLastNameKey = "Persistence.kLastNameKey"
    var lastName: String? {
        set { Foundation.UserDefaults.standard.set(newValue, forKey: kLastNameKey) }
        get { return Foundation.UserDefaults.standard.string(forKey: kLastNameKey) }
    }
    
    // Realm
    
    let localRealm = try! Realm()
    
    func getTasks() -> Results<TodoTask> {
        return localRealm.objects(TodoTask.self)
    }

    func addTask(name: String) {
        let task = TodoTask(name: name)
        
        try! localRealm.write {
            localRealm.add(task)
        }
    }
    
    func modifyTask(at: Int, name: String) {
        let taskToUpdate = localRealm.objects(TodoTask.self)[at]
        
        try! localRealm.write {
            taskToUpdate.name = name
        }
    }
    
    func deleteTask(at: Int) {
        let taskToDelete = localRealm.objects(TodoTask.self)[at]
        
        try! localRealm.write {
            localRealm.delete(taskToDelete)
        }
    }
    
    // CoreData
    
    var coreDataTasks: [NSManagedObject] = []
    
    func coreDataFetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreDataTodoTask")
        
        do {
            coreDataTasks = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func coreDataAddTask(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CoreDataTodoTask", in: managedContext)!
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        task.setValue(name, forKeyPath: "name")
    
        do {
            try managedContext.save()
            coreDataTasks.append(task)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func coreDataModifyTask(at: Int, name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let object = coreDataTasks[at]
        object.setValue(name, forKeyPath: "name")

        do {
            try managedContext.save()
            coreDataTasks[at] = object
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func coreDataDeleteTask(at: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let object = coreDataTasks[at]
        managedContext.delete(object)
        
        do {
            try managedContext.save()
            coreDataTasks.remove(at: at)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
