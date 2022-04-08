//
//  CoreDataHelper.swift
//  ClothsStore
//
//  Created by Zoombie on 07/04/22.
//

import Foundation
import CoreData


enum ItemTypes{
    case all
    case wishlist
}

//MARK: Manage Datasource


//MARK: Item

class CoreDataItemHelper: NSObject {
    
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
        
        let frController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        _fetchedResultsController = frController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
}


//MARK: Cart

protocol Refreshable:AnyObject {
    func deleteRows(forindexPath indexPath:IndexPath)
    func updateRows(forindexPath indexPath:IndexPath)
}

class CoreDataCartHelper:NSObject {

    var _fetchedResultsController: NSFetchedResultsController<Cart>? = nil
    var managedObjectContext :NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    weak var delegate:Refreshable?
    
    var fetchedResultsController: NSFetchedResultsController<Cart>
    {
    
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
                        
        let sortDescriptor = NSSortDescriptor(key: "item.name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
                        
        let frController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
        frController.delegate = self
        _fetchedResultsController = frController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
}


extension CoreDataCartHelper:NSFetchedResultsControllerDelegate {
     
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete: delegate?.deleteRows(forindexPath: indexPath!)
        case .update: delegate?.updateRows(forindexPath: indexPath!)
        default:
            break
        }
    }
}
