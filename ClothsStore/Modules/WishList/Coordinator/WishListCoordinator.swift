//
//  WishListCoordinator.swift
//  ClothsStore
//
//  Created by Zoombie on 04/04/22.
//

import Foundation
import UIKit
import Combine

//MARK: Marker Protocol
protocol WishListBaseCoordinator: AppCoordinator {}

protocol WishListBase {
    var coordinator: WishListBaseCoordinator? { get }
}

class WishListCoordinator: WishListBaseCoordinator {

    var tabbarCoordinator: TabBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    private var bindings = Set<AnyCancellable>()
    
    func start() -> UIViewController {
        // Coordinator initializes and injects viewModel
        if let wishlistVC = Storyboards.wishList.instantiateVC(WishListVC.self) {
            wishlistVC.coordinator = self
            let viewModel = WishListViewModel()
            wishlistVC.viewModel = viewModel
            
            //MARK: Badge Update WishList
            viewModel.$items
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.badgeUpdate()
                })
                .store(in: &bindings)
            
            wishlistVC.$shouldRefreshCartBadge
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.badgeUpdate()
                })
                .store(in: &bindings)
            
            rootViewController = UINavigationController(rootViewController: wishlistVC)
            (rootViewController as? UINavigationController)?.navigationBar.prefersLargeTitles = true
            return rootViewController
        }
        return UIViewController()
    }
    
    func badgeUpdate() {
        if let tabItems = (rootViewController as? UINavigationController)?.tabBarController?.tabBar.items,
           let wishListTabItem = tabItems[safe: 1],
           let basketTabItem = tabItems[safe: 2]{
            wishListTabItem.badgeValue = "\(Item.getAllWishListItems())"
            basketTabItem.badgeValue = "\(Cart.getAllCartItems())"
        }
    }
    
    func moveTo(flow: ScreenFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .wishlist(let screen):
            handleCatalogueFlow(for: screen, userData: userData)
        default:
            tabbarCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleCatalogueFlow(for screen: WishListScreen, userData: [String: Any]?) {
        switch screen {
        case .landingPage:
            navigationRootViewController?.popToRootViewController(animated: true)
        }
    }
}
