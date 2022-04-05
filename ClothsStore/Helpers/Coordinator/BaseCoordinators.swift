//
//  TabBaseCoordinator.swift
//  ClothsStore
//
//  Created by Avadhesh on 04/04/22.
//

import Foundation


protocol TabBaseCoordinator: AppCoordinator {
    var catalogueCoordinator: CatalogueBaseCoordinator { get }
    var wishlistCoordinator: WishListBaseCoordinator { get }
    var basketCoordinator: BasketBaseCoordinator { get }
}
