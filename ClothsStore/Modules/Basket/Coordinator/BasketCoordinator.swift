//
//  BasketCoordinator.swift
//  ClothsStore
//
//  Created by Zoombie on 04/04/22.
//

import Foundation
import UIKit
import Combine

//MARK: Marker Protocol
protocol BasketBaseCoordinator: AppCoordinator {}

protocol BasketBase {
    var coordinator: BasketBaseCoordinator? { get }
}

class BasketCoordinator: BasketBaseCoordinator {

    var tabbarCoordinator: TabBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    private var bindings = Set<AnyCancellable>()
    
    func start() -> UIViewController {
        
        // Coordinator initializes and injects viewModel
        if let basketVC = Storyboards.basket.instantiateVC(BasketVC.self) {
            basketVC.coordinator = self
            let viewModel = BasketViewModel()
            basketVC.viewModel = viewModel
            
            //MARK: Badge Update Cart
            viewModel.$cart
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.badgeUpdate()
                })
                .store(in: &bindings)
            
            rootViewController = UINavigationController(rootViewController: basketVC)
            (rootViewController as? UINavigationController)?.navigationBar.prefersLargeTitles = true
            return rootViewController
        }
        return UIViewController()
    }
    
    func moveTo(flow: ScreenFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .basket(let screen):
            handleCatalogueFlow(for: screen, userData: userData)
        default:
            tabbarCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleCatalogueFlow(for screen: BasketScreen, userData: [String: Any]?) {
        switch screen {
        case .landingPage:
            navigationRootViewController?.popToRootViewController(animated: true)
        }
    }
    
    func badgeUpdate() {
        if let tabItems = (rootViewController as? UINavigationController)?.tabBarController?.tabBar.items,
           let basketTabItem = tabItems[safe: 2]{
            basketTabItem.badgeValue = "\(Cart.getAllCartItems())"
        }
    }
}
