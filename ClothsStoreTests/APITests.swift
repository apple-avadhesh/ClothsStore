//
//  APITests.swift
//  ClothsStoreTests
//
//  Created by Zoombie on 11/04/22.
//


import XCTest
@testable import ClothsStore

class APITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetCatalogueItems() {
        
        let notNilExpectation : XCTestExpectation = expectation(description: "Each Property has values")
        
        let reqModel = RequestModel.init(method: .GET, path: "0f78766a6d68832d309d")
        
        APIClient().send(reqModel) { (result: Result<ProductModel, APIError>) -> Void in
            
            switch result {
            case .success(let dataModel):
                if let products = dataModel.products {
                    
                    products.forEach({ (product: Product) in
                        XCTAssertNotNil(product)
                        XCTAssertNotNil(product.stock)
                        //Observation oldPrice can be nil
                        //XCTAssertNotNil(product.oldPrice)
                        XCTAssertNotNil(product.productID)
                        XCTAssertNotNil(product.price)
                        XCTAssertNotNil(product.name)
                        XCTAssertNotNil(product.image)
                        XCTAssertNotNil(product.category)
                        
                        print("Product ID: \(product.productID ?? "")")
                    })
                    
                    notNilExpectation.fulfill()
                    
                }
            case .failure(let failure):
                print(failure)
            }
        }
        
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout error: \(error)")
            }
        }
    }
}
