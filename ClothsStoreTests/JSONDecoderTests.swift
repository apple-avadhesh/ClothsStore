//
//  JSONDecoderTests.swift
//  ClothsStoreTests
//
//  Created by Avadhesh on 10/04/22.
//

import XCTest
@testable import ClothsStore

class JSONDecoderTests: XCTestCase {
    
    override func setUp() {
      super.setUp()
    }

    override func tearDown() {
      super.tearDown()
    }
    
    //MARK: Test Catalogue JSON works
    
    func testAlbumResponseDecodeWorks() {
        
        do {
            let jsonData = try loadDataFrom(filename: "Catalogue")
          let albumResponse = try JSONDecoder().decode(ProductModel.self, from: jsonData)
          let albumCount = albumResponse.feed.results.count

          XCTAssertTrue(albumCount == 100, "Expected to decode 100 albums, but only decoded: \(albumCount) albums")

        } catch let err {
          fail(message: err.localizedDescription)
        }
    }
    
    public func loadDataFrom(filename: String, fileType: String = "json") throws -> Data {
        let testBundle = Bundle(for: type(of: self))
        
        guard let path = testBundle.path(forResource: filename, ofType: fileType) else {
            throw (self.generateFileMissingError(filename: filename))
        }
        
        return try Data(contentsOf: URL(fileURLWithPath: path))
    }

}
