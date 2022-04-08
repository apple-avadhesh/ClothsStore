//
//  UIImageView+Extension.swift
//  ClothsStore
//
//  Created by Zoombie on 06/04/22.
//

import Foundation


import Foundation
import UIKit

extension UIImageView {
    func setImageWithURLString(urlString : String, placeholderImageFileName : String?){
        if let placeholderImageFileName = placeholderImageFileName {
            self.setImageOnMainThread(imageToSet: UIImage(named: placeholderImageFileName))
        }
        let url = URL(string: urlString)!
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30.0)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error : Error?) -> Void in
            guard let data = data else {
                print("Error getting image from url \n \(String(describing: error?.localizedDescription))")
                return
            }
            let loadedImage = UIImage(data: data)
            self.setImageOnMainThread(imageToSet: loadedImage)
        }
        task.resume()
    }
    
    func setImageOnMainThread(imageToSet : UIImage?) {
        DispatchQueue.main.async {
            self.image = imageToSet
        }
    }
}
