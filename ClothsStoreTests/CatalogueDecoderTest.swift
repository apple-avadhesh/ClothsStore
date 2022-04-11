//
//  DecoderTest.swift
//  ClothsStoreTests
//
//  Created by Zoombie on 11/04/22.
//

import XCTest
@testable import ClothsStore

final class CatalogueDecoderTest: XCTestCase, TestHelper {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCatalogueResponseDecoder() {
        do {
            let jsonData = try loadDataFrom(filename: "Catalogue")
            let catalogueResponse = try JSONDecoder().decode(ProductModel.self, from: jsonData)
            let catalogueCount = catalogueResponse.products!.count
            
            XCTAssertTrue(catalogueCount == 12, "Expected to decode 14 items, but only decoded: \(catalogueCount) albums")
            
        } catch let err {
            XCTFail("Catalogue failed \(err.localizedDescription) line: \(#line)")
        }
    }
}
