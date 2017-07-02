//
//  Extensions.swift
//  JSON
//
//  Created by Timothy Hull on 6/27/17.
//  Copyright © 2017 Sponti. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage


// Image Cache
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        // Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        // Otherwise fire off a new download
        Alamofire.request(urlString)
            .responseImage { response in
                
                if let downloadedImage = response.result.value {
                    // image is here.
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
        }
    }
}
