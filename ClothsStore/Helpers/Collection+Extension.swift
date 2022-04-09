//
//  fdsf.swift
//  ClothsStore
//
//  Created by Zoombie on 09/04/22.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
