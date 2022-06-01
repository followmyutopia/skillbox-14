//
//  Persistence.swift
//  Module 14
//
//  Created by Avicus Delacroix on 01.06.2022.
//

import Foundation
import RealmSwift

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

    func addTask(name: String) {
        let task = TodoTask(name: name)
        
        try! localRealm.write {
            localRealm.add(task)
        }
    }
    
    func getTasks() -> Results<TodoTask> {
        return localRealm.objects(TodoTask.self)
    }
}
