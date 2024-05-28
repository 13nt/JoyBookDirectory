//
//  DataHelper.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 29/05/2024.
//

import CoreData

class DataHelper {
    
    static let shared = DataHelper()

    private init() {}
    
    func fetchData(for username: String) -> (username: String, password: String)? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        
        do {
            let users = try CoreDataManager.shared.context.fetch(fetchRequest)
            if let user = users.first {
                return (user.username ?? "", user.password ?? "")
            }
        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
        }
        return nil
    }
    
    func saveData(username: String, password: String) -> Bool {
        if fetchData(for: username) != nil {
            // User already exists, return false indicating failure to save
            return false
        }
        
        let newUser = User(context: CoreDataManager.shared.context)
        newUser.username = username
        newUser.password = password
        
        CoreDataManager.shared.saveContext()
        return true
    }
    
    func getAllUsers() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try CoreDataManager.shared.context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch users: \(error.localizedDescription)")
            return []
        }
    }

//    func fetchData() -> (username: String, password: String)? {
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//
//        do {
//            let users = try CoreDataManager.shared.context.fetch(fetchRequest)
//            if let user = users.first {
//                print("Fetch username: \(String(describing: user.username)), password: \(String(describing: user.password))")
//                return (String(user.username ?? ""), String(user.password ?? ""))
//            } else {
//                saveData(username: "", password: "")
//                return nil
//            }
//        } catch {
//            print("Failed to fetch data: \(error.localizedDescription)")
//        }
//        return nil
//    }
//
//    func saveData(username: String, password: String) {
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//
//        do {
//            let users = try CoreDataManager.shared.context.fetch(fetchRequest)
//
//            if let user = users.first {
//                user.username = username
//                user.password = password
//            } else {
//                createInitialData(username: username, password: password)
//            }
//
//            CoreDataManager.shared.saveContext()
//
//        } catch {
//            print("Failed to fetch data: \(error.localizedDescription)")
//        }
//    }
//
//    private func createInitialData(username: String, password: String) {
//        let user = User(context: CoreDataManager.shared.context)
//        user.username = username
//        user.password = password
//
//        CoreDataManager.shared.saveContext()
//    }
}
