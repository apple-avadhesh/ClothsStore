//
//  WishListCell.swift
//  ClothsStore
//
//  Created by Avadhesh on 06/04/22.
//

import Foundation
import UIKit


class WishListCell: UITableViewCell, CellReusable {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var stockLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!

    func configure(with product: Item) {
        nameLabel.text = product.name
//        priceLabel.text = product.price.toPriceString()
//        stockLabel.text = "\(product.stock)"
        
    }
}
