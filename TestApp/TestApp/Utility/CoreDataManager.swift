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
    
    static func addUser(userName: String, password: String) {
        let user = fetchUser(userName: userName) ?? User(context: context)
        user.userName = userName
        user.password = password
    }
    
    static func fetchUser(userName: String, password: String = "") -> User? {
        do {
            let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
            if password.isEmpty {
                fetchRequest.predicate = NSPredicate(format: "userName == %@", userName)
            } else {
                fetchRequest.predicate = NSPredicate(format: "userName == %@ && password == %@", userName, password)
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
