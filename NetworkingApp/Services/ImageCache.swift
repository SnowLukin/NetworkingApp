//
//  ImageCache.swift
//  NetworkingApp
//
//  Created by Snow Lukin on 22.01.2022.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
