//
//  CoreDataHelper.swift
//  ClothsStore
//
//  Created by Avadhesh on 07/04/22.
//

import Foundation
import CoreData


enum ItemTypes{
    case all
    case wishlist
}

//MARK: Manage Datasource
class CoreDataHelper: NSObject {
    
    var _fetchedResultsController: NSFetchedResultsController<Item>? = nil
    var managedObjectContext :NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    var type = ItemTypes.all

    var fetchedResultsController: NSFetchedResultsController<Item> {

        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        switch type {
        case .all:
            let predicate = NSPredicate(format: "productID != nil")
            fetchRequest.predicate = predicate
        case .wishlist:
            let predicate = NSPredicate(format: "productID != nil &&  isFavourite == 1")
            fetchRequest.predicate = predicate
        }
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
}
