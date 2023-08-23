//
//  CoreDataManager.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 22.08.2023.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    enum CoreDataError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
    func addNews(news: News?) throws {
        guard let news = news else { return }
        
        let context = managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "ReadList", in: context)!
        let movieEntity = NSManagedObject(entity: entity, insertInto: context)
        
        movieEntity.setValue(news.title, forKey: "title")
        movieEntity.setValue(news.url, forKey: "url")
        
        try saveContext()
    }
    
    func removeNews(news: News?) throws {
        guard let news = news else { return }
        
        let context = managedObjectContext
        let fetchRequest: NSFetchRequest<ReadList> = ReadList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url = %@ ", news.url ?? "")
        
        do {
            let results = try context.fetch(fetchRequest)
            for movieEntity in results {
                context.delete(movieEntity)
            }
            
            try saveContext()
        } catch {
            throw CoreDataError.failedToDeleteData
        }
    }
    
    //Check the news from CoreData
    func isNewsInCoreData(news: News) -> Bool {
        let context = managedObjectContext
        let fetchRequest: NSFetchRequest<ReadList> = ReadList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url = %@", news.url ?? "")
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Failed to check Core Data: \(error)")
            return false
        }
    }

    
    func saveContext() throws {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw CoreDataError.failedToSaveData
            }
        }
    }
}
