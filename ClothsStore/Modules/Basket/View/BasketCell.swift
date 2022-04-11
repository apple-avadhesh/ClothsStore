//
//  BasketCell.swift
//  ClothsStore
//
//  Created by Zoombie on 08/04/22.
//

import Foundation
import UIKit


class BasketCell: UITableViewCell, CellReusable {
    
    //MARK: Outlet
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    
    //MARK: Properties
    
    var quantity: Int = 1
    
    var item: Item!
    
    var stepperUpdatedCallback:((Int, UIButton) -> Void)?

    var cart:Cart? {
        didSet{
            guard let cart = cart else { return }
            
            if let item = cart.item {
                nameLabel.text = item.name
                priceLabel.text = item.price.currencyString()
                productImageView.setImageWithURLString(urlString: item.image ?? "", placeholderImageFileName: "placeholderImage")
                self.item = item
            }
            
            quantityLabel.text = "\(cart.quantity)"
            quantity = Int(cart.quantity)
        }
    }
    
    //MARK: Actions
    @IBAction func stepperButtonTapped(sender: UIButton) {
        
        if sender.tag == 0 {
            quantity = quantity + 1
        } else if quantity > 0 {
            quantity = quantity - 1
        }
        
        stepperUpdatedCallback?(quantity, sender)
    }
}
