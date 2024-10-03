//
//  RealmManager.swift
//  Schedule
//
//  Created by Никита Козловский on 20.09.2024.


import RealmSwift

class RealmManagerSave {
    
    static let shared = RealmManagerSave()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveScheduleModel(model: ScheduleModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
}

class RealmManagerDelete {
    
    static let shared = RealmManagerDelete()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func deleteScheduleModel(model: ScheduleModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
}
