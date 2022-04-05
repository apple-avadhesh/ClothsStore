//
//  CatalogueCoordinator.swift
//  ClothsStore
//
//  Created by Avadhesh on 04/04/22.
//

import Foundation
import UIKit

//MARK: Marker Protocol
protocol CatalogueBaseCoordinator: AppCoordinator {}

protocol CatalogueBase {
    var coordinator: CatalogueBaseCoordinator? { get }
}

class CatalogueCoordinator: CatalogueBaseCoordinator {

    var tabbarCoordinator: TabBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: CatalogueVC(coordinator: self))
        return rootViewController
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
            break
        }
    }
}
