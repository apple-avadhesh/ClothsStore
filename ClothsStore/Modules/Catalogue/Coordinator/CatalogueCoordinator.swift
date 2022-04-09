//
//  CatalogueCoordinator.swift
//  ClothsStore
//
//  Created by Zoombie on 04/04/22.
//

import Foundation
import UIKit
import Combine

//MARK: Marker Protocol
protocol CatalogueBaseCoordinator: AppCoordinator {}

protocol CatalogueBase {
    var coordinator: CatalogueBaseCoordinator? { get }
}

class CatalogueCoordinator: CatalogueBaseCoordinator {

    var tabbarCoordinator: TabBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    private var bindings = Set<AnyCancellable>()

    func start() -> UIViewController {
        
        // Coordinator initializes and injects viewModel
        if let catalogueVC = Storyboards.catalogue.instantiateVC(CatalogueVC.self) {
            catalogueVC.coordinator = self
            let viewModel = CatalogueViewModel()
            catalogueVC.viewModel = viewModel
            rootViewController = UINavigationController(rootViewController: catalogueVC)
            (rootViewController as? UINavigationController)?.navigationBar.prefersLargeTitles = true
            return rootViewController
        }
        return UIViewController()
    }
    
    func moveTo(flow: ScreenFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .catalogue(let screen):
            handleCatalogueFlow(for: screen, userData: userData)
        default:
            tabbarCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleCatalogueFlow(for screen: CatalogueScreen, userData: [String: Any]?) {
        switch screen {
        case .landingPage:
            navigationRootViewController?.popToRootViewController(animated: true)
        case .productDetail:
            guard let item = userData?["product"] as? Item else { return }
            goToProductDetail(item: item)
        }
    }
    
    func goToProductDetail(item: Item) {
        if let productDetailVC = Storyboards.productDetail.instantiateVC(ProductDetailContainerVC.self) {
            productDetailVC.coordinator = self
            productDetailVC.item = item
            
            //MARK: Badge Update
            productDetailVC.item.publisher(for: \.isFavourite,
                                           options: [.new])
            .sink { _ in
                self.badgeUpdate()
            }
            .store(in: &bindings)
            
            productDetailVC.$shouldRefreshCartBadge
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.badgeUpdate()
                })
                .store(in: &bindings)
            
            navigationRootViewController?.present(UINavigationController(rootViewController: productDetailVC), animated: true)
        }
    }
    
    func badgeUpdate() {
        if let tabItems = (rootViewController as? UINavigationController)?.tabBarController?.tabBar.items,
           let wishListTabItem = tabItems[safe: 1],
           let basketTabItem = tabItems[safe: 2]{
            wishListTabItem.badgeValue = "\(Item.getAllWishListItems())"
            basketTabItem.badgeValue = "\(Cart.getAllCartItems())"
        }
    }
}
