//
//  WishListCoordinator.swift
//  ClothsStore
//
//  Created by Avadhesh on 04/04/22.
//

import Foundation
import UIKit

//MARK: Marker Protocol
protocol WishListBaseCoordinator: AppCoordinator {}

protocol WishListBase {
    var coordinator: WishListBaseCoordinator? { get }
}

class WishListCoordinator: WishListBaseCoordinator {

    var tabbarCoordinator: TabBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        // Coordinator initializes and injects viewModel
        if let wishlistVC = Storyboards.wishList.instantiateVC(WishListVC.self) {
            wishlistVC.coordinator = self
            let viewModel = WishListViewModel()
            wishlistVC.viewModel = viewModel
            rootViewController = UINavigationController(rootViewController: wishlistVC)
            (rootViewController as? UINavigationController)?.navigationBar.prefersLargeTitles = true
            return rootViewController
        }
        return UIViewController()
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
