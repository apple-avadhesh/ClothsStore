//
//  Item+CoreData.swift
//  ClothsStore
//
//  Created by Zoombie on 07/04/22.
//

import Foundation
import CoreData

extension Item {
    class func loadProducts(products: [Product], withContainer container:NSPersistentContainer) {
        for product in products {
            let item = Item(context: container.viewContext)
            self.configure(item: item, using: product)
        }
        
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    class func configure(item: Item, using jsonObject: Product) {

        item.name = jsonObject.name
        item.category = jsonObject.category?.rawValue
        item.image = jsonObject.image
        
        if let prodID = jsonObject.productID {
            item.productID = Int16(prodID)!
        } else {
            item.productID = 0
        }
        
        if let oldPr = jsonObject.oldPrice {
            item.oldPrice = oldPr
        } else {
            item.oldPrice = 0.0
        }
        
        if let pr = jsonObject.price {
            item.price = pr
        } else {
            item.price = 0.0
        }
        
        if let stck = jsonObject.stock {
            item.stock = Int16(exactly: stck)!
        } else {
            item.stock = 0
        }
    }
    
    class func getAllWishListItems() -> Int {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            fetchRequest.predicate = NSPredicate(format: "isFavourite == 1")
            let result = try context.fetch(fetchRequest)
            return result.count
        } catch {
            print("Could not fetch wishlist")
        }
        return 0
    }
    
    func updateWishlist() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productID == \(self.productID)")
        do {
            let result = try context.fetch(fetchRequest)
            if let product = result.first{
                product.isFavourite = !product.isFavourite
            }
            CoreDataManager.shared.saveContext()
        } catch {
            print("Could not fetch product")
        }
    }
}
