//
//  WishListViewModel.swift
//  ClothsStore
//
//  Created by Zoombie on 07/04/22.
//

import CoreData

class WishListViewModel {
    
    //MARK: Properties
    
    @Published var items = [Item]()

    var cdHelper = CoreDataItemHelper()

    // MARK: Methods
        
    func fetchData() {
        self.cdHelper.type = .wishlist
        self.items = self.cdHelper.fetchedResultsController.fetchedObjects!
    }
}
