//
//  U.swift
//  ClothsStore
//
//  Created by Zoombie on 07/04/22.
//

import Foundation

extension UserDefaults{
    
    static let firstLoad = "firstLoad"
    
    func getFirstLoad() -> Bool{
        return UserDefaults.standard.bool(forKey: UserDefaults.firstLoad)
    }
    func setFirsLoad(){
        UserDefaults.standard.set(true, forKey: UserDefaults.firstLoad)
    }
}
