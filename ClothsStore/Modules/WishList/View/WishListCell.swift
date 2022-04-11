//
//  WishListCell.swift
//  ClothsStore
//
//  Created by Zoombie on 06/04/22.
//

import Foundation
import UIKit


class WishListCell: UITableViewCell, CellReusable {
    
    //MARK: Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var stockLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    
    //Properties
    
    var addToCartCallback:(() -> Void)?

    var item: Item? {
        didSet{
            guard let item = item else {return}
            nameLabel.text = item.name
            priceLabel.text = item.price.currencyString()
            stockLabel.text = "\(item.stock)"
            productImageView.setImageWithURLString(urlString: item.image ?? "", placeholderImageFileName: "placeholderImage")
        }
    }
    
    //MARK: Actions
    @IBAction func addToCart(_ sender: Any) {
        guard let _ = item else {return}
        addToCartCallback?()
    }
}
