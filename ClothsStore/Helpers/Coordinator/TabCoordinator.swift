//
//  TabCoordinator.swift
//  ClothsStore
//
//  Created by Zoombie on 04/04/22.
//

import Foundation
import UIKit

class TabCoordinator: TabBaseCoordinator {
    var tabbarCoordinator: TabBaseCoordinator?
    
    lazy var catalogueCoordinator: CatalogueBaseCoordinator = CatalogueCoordinator()
    lazy var wishlistCoordinator: WishListBaseCoordinator = WishListCoordinator()
    lazy var basketCoordinator: BasketBaseCoordinator = BasketCoordinator()

    
    lazy var rootViewController: UIViewController  = UITabBarController()
    
    func start() -> UIViewController {
        
        let catalogVC = catalogueCoordinator.start()
        catalogueCoordinator.tabbarCoordinator = self
        catalogVC.tabBarItem = UITabBarItem(title: "Catalogue".uppercased(),
                                            image: UIImage(systemName: "rectangle.stack.badge.plus"),
                                            tag: 0)
        
        let wishListVC = wishlistCoordinator.start()
        wishlistCoordinator.tabbarCoordinator = self
        wishListVC.tabBarItem = UITabBarItem(title: "Wishlist".uppercased(),
                                             image: UIImage(systemName: "suit.heart"),
                                             tag: 1)
        
        let basketVC = basketCoordinator.start()
        basketCoordinator.tabbarCoordinator = self
        basketVC.tabBarItem = UITabBarItem(title: "basket".uppercased(),
                                           image: UIImage(systemName: "cart"),
                                           tag: 1)
        
        (rootViewController as? UITabBarController)?.viewControllers = [catalogVC,
                                                                        wishListVC,
                                                                        basketVC]
        
        return rootViewController
    }
        
    func moveTo(flow: ScreenFlow, userData: [String : Any]?) {
        switch flow {
        case .catalogue:
            goToCatalogueFlow(flow)
        case .basket:
            goToBasketFlow(flow)
        case .wishlist:
            goToWishListFlow(flow)
        }
    }
    
    private func goToWishListFlow(_ flow: ScreenFlow) {
        wishlistCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }
    
    private func goToCatalogueFlow(_ flow: ScreenFlow) {
        catalogueCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
    }
    
    private func goToBasketFlow(_ flow: ScreenFlow) {
        basketCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
}
