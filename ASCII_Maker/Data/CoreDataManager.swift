//
//  CoreDataManager.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/24/25.
//

import CoreData
import UIKit


final class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "History")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    static let shared = CoreDataManager()
    
    private init() {}
}


// MARK: - CRUD Method
extension CoreDataManager {
    public func saveHistory(image: Data, result: String, pixels: String) {
        let context = self.persistentContainer.viewContext
        
        let entity = History(context: context)
        entity.id = UUID()
        entity.timestamp = .now
        entity.image = image
        entity.result = result
        entity.pixels = pixels
        
        self.saveContext()
    }
    
    public func fetchHistory() -> [HistoryDTO] {
        do {
            let fetchedResults = try self.loadHistories()
            
            let results = fetchedResults.map {
                HistoryDTO(
                    id: $0.id ?? .init(),
                    image: UIImage(data: $0.image ?? .init()) ?? .doro,
                    pixels: $0.pixels ?? "알 수 없음",
                    result: $0.result ?? "알 수 없음",
                    timestamp: $0.timestamp ?? .distantPast
                )
            }.sorted { $0.timestamp > $1.timestamp }
            
            return results
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}



// MARK: - Internal method

extension CoreDataManager {
    private func loadHistories() throws -> [History] {
        let context = self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<History>(entityName: "History")
        
        let result = try context.fetch(fetchRequest)
        return result
    }
    
    
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                if let error = error as NSError? {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
