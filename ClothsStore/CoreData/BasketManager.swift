//
//  BasketManager.swift
//  ClothsStore
//
//  Created by Avadhesh on 07/04/22.
//

import Foundation

protocol BasketBadgeDelegate {
    func basketListDidChange()
}

protocol BasketBadgeProtocol {
    
    var basketList: [Cart] { get }
    var delegate: BasketBadgeDelegate? { get set }
    var totalAmount: Double { get }
    var displayTotalAmount: String { get }
    func fetchBasketList()
    func deleteItem(atIndex: Int)
}

class BasketViewModel: BasketBadgeProtocol {
    
    var basketList: [Cart] = [] {
        didSet {
           // setTotal()
            delegate?.basketListDidChange()
        }
    }
    
    var delegate: BasketBadgeDelegate?
    
    var displayTotalAmount: String = "Total : 0"

    func fetchBasketList() {
        
    }
    
    func deleteItem(atIndex: Int) {
        
    }
    
//    private func setTotal() {
//        totalAmount = basketList.map({($0.price) * Double($0.quantity)}).reduce(0, +)
//    }
    
    var totalAmount: Double = 0 {
        didSet {
            if basketList.count == 0 {
                displayTotalAmount = "No Items in the Cart"
            }else {
                displayTotalAmount = "Total : \(totalAmount)"
            }
        }
    }  
}
