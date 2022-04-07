//
//  CoreDataStack.swift
//  ClothsStore
//
//  Created by Avadhesh on 06/04/22.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Cart")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /*Insert*/
//    func insertCart(product: Product, quantity : Int16) {
//
//        if let list = fetchCartList() {
//            let outputfiler = list.filter({
//                $0.name == product.name &&
//                $0.image == product.image
//            })
//
//            if let oldCart = outputfiler.first {
//                update(quantity: oldCart.quantity + 1, cart: oldCart)
//                return
//            }
//        }
//
//        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
//
//        let entity = NSEntityDescription.entity(forEntityName: "Cart", in: managedContext)!
//        let cart = NSManagedObject(entity: entity, insertInto: managedContext) as? Cart
//
//        cart?.quantity = quantity
//        cart?.name = product.name
//        cart?.category = product.category?.rawValue
//        cart?.image = product.image
//
//        if let prodID = product.productID {
//            cart?.productID = Int16(prodID)!
//        } else {
//            cart?.productID = 0
//        }
//
//        if let oldPr = product.oldPrice {
//            cart?.oldPrice = oldPr
//        } else {
//            cart?.oldPrice = 0.0
//        }
//
//
//        if let stck = product.stock {
//            cart?.stock = Int16(exactly: stck)!
//        } else {
//            cart?.stock = 0
//        }
//
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
    
//    func deleteAllData(_ entity:String) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        do {
//            let context = CoreDataManager.shared.persistentContainer.viewContext
//            let results = try context.fetch(fetchRequest)
//            for object in results {
//                guard let objectData = object as? NSManagedObject else {continue}
//                context.delete(objectData)
//            }
//        } catch let error {
//            print("Detele all data in \(entity) error :", error)
//        }
//    }
    
//    func update(quantity : Int16, cart : Cart) {
//
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//
//        cart.quantity = quantity
//        do {
//            try context.save()
//            print("saved!")
//        } catch let error as NSError  {
//            print("Could not save \(error), \(error.userInfo)")
//        }
//    }
    
    /*delete*/
//    func delete(cart : Cart){
//
//        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
//
//        managedContext.delete(cart)
//
//        do {
//            try managedContext.save()
//        } catch let error as NSError  {
//            print("Could not save \(error), \(error.userInfo)")
//        }
//    }
    
//    func fetchCartList() -> [Cart]? {
//
//        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
//
//        do {
//            let cartList = try managedContext.fetch(fetchRequest)
//            return cartList as? [Cart]
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//            return nil
//        }
//    }
    
//    func getCartItem(productId: String) -> Cart? {
//
//        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
//        fetchRequest.predicate = NSPredicate(format: "productID == %@", productId)
//        do {
//            let cartList = try managedContext.fetch(fetchRequest)
//            return cartList.first as? Cart
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//            return nil
//        }
//    }
    
//    func getTotalItems() -> Int16 {
//
//        if let arrCart = fetchCartList() {
//            return arrCart.map{ $0.quantity}.reduce(0, +)
//        } else {
//            return 0
//        }
//    }
}
