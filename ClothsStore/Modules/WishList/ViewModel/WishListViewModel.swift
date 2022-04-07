//
//  WishListViewModel.swift
//  ClothsStore
//
//  Created by Avadhesh on 07/04/22.
//

import CoreData

class WishListViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published var items = [Item]()
    var cdHelper = CoreDataHelper()

    // MARK: Methods
        
    func fetchData() {
        self.cdHelper.type = .wishlist
        self.items = self.cdHelper.fetchedResultsController.fetchedObjects!
    }
}
