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

    func configure(with item: Item) {
        nameLabel.text = item.name
        priceLabel.text = item.price.currencyString()
        stockLabel.text = "\(item.stock)"
        productImageView.setImageWithURLString(urlString: item.image ?? "", placeholderImageFileName: "placeholderImage")
    }
}
