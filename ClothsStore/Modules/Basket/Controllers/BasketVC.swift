//
//  BasketVC.swift
//  ClothsStore
//
//  Created by Avadhesh on 04/04/22.
//

import Foundation
import UIKit

class BasketVC: UIViewController, BasketBase {
   
    // MARK: Outlets
    
    // MARK: - Variables
    var coordinator: BasketBaseCoordinator?
    
    // MARK: - Initializers
    init(coordinator: BasketBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Catalogue"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
