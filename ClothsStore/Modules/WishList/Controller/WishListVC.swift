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
    var cdHelper = CoreDataHelper()

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
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        title = "Wishlist"
        
        cdHelper.type = .wishlist
    }
}

extension WishListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cdHelper.fetchedResultsController.fetchedObjects!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: WishListCell.self, for: indexPath)
        cell.configure(with: cdHelper.fetchedResultsController.fetchedObjects![indexPath.row])
        return cell
    }
}
