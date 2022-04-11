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

//  func parseDataFrom<T: Decodable>(
//    decodableType: T.Type,
//    filename: FileName,
//    fileType: FileType
//  ) throws -> T {
//    do {
//      let data = try loadDataFrom(filename: filename, fileType: fileType)
//      return try JSONDecoder().decode(decodableType, from: data)
//    } catch let err {
//      throw (err)
//    }
//  }
//
//  func makeSingleAlbum() throws -> Album? {
//    return try parseDataFrom(
//      decodableType: AlbumResponse.self,
//      filename: .oneAlbumStub,
//      fileType: .json
//    ).feed.results.first
//  }
//
//  func make100Albums() throws -> [Album] {
//    return try parseDataFrom(
//      decodableType: AlbumResponse.self,
//      filename: .fullStub,
//      fileType: .json
//    ).feed.results
//  }
}
