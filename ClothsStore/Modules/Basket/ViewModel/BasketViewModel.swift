//
//  BasketViewModel.swift
//  ClothsStore
//
//  Created by Zoombie on 08/04/22.
//

import Foundation

class BasketViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published var cart = [Cart]()
    var cdHelper = CoreDataCartHelper()

    // MARK: Methods
        
    func fetchData() {
        self.cart = self.cdHelper.fetchedResultsController.fetchedObjects!
        print("data fetched")
    }
}
