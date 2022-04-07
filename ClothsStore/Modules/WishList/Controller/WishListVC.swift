//
//  WishListVC.swift
//  ClothsStore
//
//  Created by Avadhesh on 07/04/22.
//

import Foundation
import UIKit

class WishListVC: UIViewController, WishListBase {
   
    // MARK: Outlets
    
    // MARK: - Variables
    var coordinator: WishListBaseCoordinator?
    
    // MARK: - Initializers
    init(coordinator: WishListBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        title = "Wishlist"
    }
}