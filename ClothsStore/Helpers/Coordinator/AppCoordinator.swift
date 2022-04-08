//
//  AppCoordinator.swift
//  ClothsStore
//
//  Created by Zoombie on 04/04/22.
//

import Foundation
import UIKit

protocol AppFlow: AnyObject {
    var tabbarCoordinator: TabBaseCoordinator? { get set }
}

protocol AppCoordinator: AppFlow {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    func moveTo(flow: ScreenFlow, userData: [String: Any]?)
}

extension AppCoordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
}
