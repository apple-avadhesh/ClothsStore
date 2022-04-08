//
//  ScreenFlow.swift
//  ClothsStore
//
//  Created by Zoombie on 04/04/22.
//

import Foundation

enum ScreenFlow {
    case catalogue(CatalogueScreen)
    case basket(BasketScreen)
    case wishlist(WishListScreen)
}

enum CatalogueScreen {
    case landingPage
    case productDetail
}

enum BasketScreen {
    case landingPage
}

enum WishListScreen {
    case landingPage
}
