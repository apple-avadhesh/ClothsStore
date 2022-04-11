//
//  Storyboard+Extension.swift
//  ClothsStore
//
//  Created by Zoombie on 06/04/22.
//

import Foundation
import UIKit


enum Storyboards: String {
    case catalogue = "Catalogue"
    case productDetail = "ProductDetail"
    case basket = "Basket"
    case wishList = "WishList"

    func instantiateVC<T>(_ identifier: T.Type) -> T?  {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: String(describing: identifier)) as? T else { return nil}
        return viewcontroller
    }
}


