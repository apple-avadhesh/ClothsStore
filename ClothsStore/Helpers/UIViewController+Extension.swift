//
//  UIViewController+Extension.swift
//  ClothsStore
//
//  Created by Zoombie on 11/04/22.
//

import UIKit


extension UIViewController {
    
    public func showToast(message : String, seconds: Double = 1.0) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        toast.view.alpha = 0.5
        present(toast, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            toast.dismiss(animated: true)
        }
    }
}

extension UIViewController {
    
    @discardableResult
    func checkAvailability(forItem item: Item) -> Bool {
        if item.stock == 0 {
            self.showToast(message: "Out of Stock!!!")
            return false
        } else if item.stock > 0 {
            if let cartItemCount = item.relationship?.quantity {
                if cartItemCount < item.stock {
                    Cart.updateCart(withItem: item)
                    self.showToast(message: "Item Added!!!")
                    return true
                } else {
                    self.showToast(message: "Stock Exhausted!!!")
                    return false
                }
            } else {
                Cart.updateCart(withItem: item)
                self.showToast(message: "Item Added!!!")
                return true
            }
        }
        return false
    }
    
    @discardableResult
    func checkAvailabilityForCart(forItem item: Item, quantity: Int) -> Bool {
        
        if quantity <= item.stock {
            Cart.updateCart(withItem: item,forQuantity: quantity)
            return true
        } else {
            self.showToast(message: "Stock Exhausted!!!")
            return false
        }
    }
}


