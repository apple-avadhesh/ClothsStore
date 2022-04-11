//
//  Cart+CoreData.swift
//  ClothsStore
//
//  Created by Zoombie on 08/04/22.
//

import Foundation
import CoreData

extension Cart {
    
    class func updateCart(withItem item:Item) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productId == \(item.productID)")
        do {
            let result = try context.fetch(fetchRequest)
            if let cart = result.first {
                cart.quantity += 1
                cart.subTotal = (item.price * Double(cart.quantity))
            } else {
                let cart = Cart.init(context: context)
                cart.quantity = 1
                cart.productId = item.productID
                cart.item = item
                cart.subTotal = item.price
            }
            CoreDataManager.shared.saveContext()
        } catch {
            print("Could not fetch cart")
        }
    }
   
    class func updateCart(withItem item:Item, forQuantity quantity:Int){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productId == \(item.productID)")
        do {
            let result = try context.fetch(fetchRequest)
            if let cart = result.first{
                if quantity == 0 {
                    context.delete(cart)
                }else{
                    cart.quantity = Int64(quantity)
                    cart.subTotal = Double((item.price * Double(cart.quantity)))
                }
            }
            CoreDataManager.shared.saveContext()
        } catch {
            print("Could not fetch cart")
        }
    }
    
    class func getAllCartItems() -> Int {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            let count = result.reduce(0) { (value, item)  in
                value + item.quantity
            }
            return Int(count)
        } catch {
            print("Could not fetch all cart items")
        }
        return 0
    }
    
    class func cartItemsTotal() -> Double {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            let count = result.reduce(0) { (value, item)  in
                value + item.subTotal
            }
            return count
        } catch {
            print("Could not fetch all cart items")
        }
        return 0
    }
}
