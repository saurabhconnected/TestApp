//
//  CoreDataManager.swift
//  TestApp
//
//  Created by Saurabh Shukla on 22/08/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let context = AppDelegate.shared.persistentContainer.viewContext
    
    static func addUser(username: String, password: String) {
        let user = fetchUser(username: username) ?? User(context: context)
        user.username = username
        user.password = password
    }
    
    static func fetchUser(username: String, password: String = "") -> User? {
        do {
            let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
            if password.isEmpty {
                fetchRequest.predicate = NSPredicate(format: "username == %@", username)
            } else {
                fetchRequest.predicate = NSPredicate(format: "username == %@ && password == %@", username, password)
            }
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults.first
        }
        catch {
            return nil
        }
    }
    
    static func saveData() {
        AppDelegate.shared.saveContext()
    }
}
