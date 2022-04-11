//
//  TestHelper.swift
//  ClothsStoreTests
//
//  Created by Zoombie on 11/04/22.
//

import Foundation


protocol TestHelper: AnyObject {}

extension TestHelper {
  private func makeFileMissingError(filename: String) -> Error {
    return NSError(
      domain: "",
      code: 404,
      userInfo: [NSLocalizedDescriptionKey: "File \(filename) not found in test bundle"]
    )
  }

  public func loadDataFrom(filename: String) throws -> Data {
    let testBundle = Bundle(for: type(of: self))

    guard let path = testBundle.path(forResource: filename, ofType: "json") else {
      throw (self.makeFileMissingError(filename: filename))
    }

    return try Data(contentsOf: URL(fileURLWithPath: path))
  }
}
