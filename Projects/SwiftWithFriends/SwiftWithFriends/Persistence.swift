//
//  Persistence.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/27/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        let class_member = ClassMember(context: viewContext)
        class_member.id = 882060147325108225
        class_member.name = "Geoffrie Alena"
        class_member.username = "MirandaCalls"
        class_member.bio = "🏳️‍⚧️ Curious web developer with a deep love for anime and music. Learning Swift and iOS in #100DaysOfSwiftUI. Stay shiny everyone! (she/her)"
        class_member.profileImageUrl = "https://pbs.twimg.com/profile_images/1459648977104687109/9evn-YVz_normal.jpg"
        class_member.url = "https://t.co/TtFeKcMnZ4"
        class_member.joinedAt = Date()
        
        let friend = Friend(context: viewContext)
        friend.id = 882060147325108225
        friend.classMember = class_member
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SwiftWithFriends")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
