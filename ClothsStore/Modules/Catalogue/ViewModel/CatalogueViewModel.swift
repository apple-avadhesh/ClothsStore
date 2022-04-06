//
//  CatalogueViewModel.swift
//  ClothsStore
//
//  Created by Avadhesh on 05/04/22.
//

import Foundation

class CatalogueViewModel: ObservableObject {
    
    //MARK: Properties
    
    var reloadTableCompletion: () -> () = {  }
    
    @Published var products = [Product]()
    
    
    // MARK: Methods
    
    // Test: https://api.npoint.io/0f78766a6d68832d309d
    
    func fetchData() {
        let reqModel = RequestModel.init(method: .GET, path: "0f78766a6d68832d309d")
        
        APIClient().send(reqModel) { (result: Result<ProductModel, APIError>) -> Void in
            
            switch result {
            case .success(let dataModel):
                if let products = dataModel.products {
                    DispatchQueue.main.async {
                        self.products = products
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
