//
//  TestStubs.swift
//  ClothsStoreTests
//
//  Created by Zoombie on 10/04/22.
//

import Foundation

protocol NetworkStubbing: AnyObject {}


extension NetworkStubbing {
  private func generateFileMissingError(filename: String) -> Error {
    return NSError(
      domain: "",
      code: 404,
      userInfo: [NSLocalizedDescriptionKey: "File \(filename) not found in test bundle"]
    )
  }
}
