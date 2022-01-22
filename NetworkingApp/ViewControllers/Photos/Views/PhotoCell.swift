//
//  PhotoCell.swift
//  NetworkingApp
//
//  Created by Snow Lukin on 19.01.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var photoImage: UIImageView!
    
    // MARK: Private Methods
    private var imageURL: URL? {
        didSet {
            photoImage.image = UIImage(named: "defaultPhoto")
            updateImage()
        }
    }
    
    // MARK: Public Methods
    func configure(with photo: Photo?) {
        guard let stringUrl = photo?.url else { return }
        self.imageURL = URL(string: stringUrl)
    }
    
    // MARK: Private Methods
    private func updateImage() {
        guard let url = imageURL else { return }
        getImage(from: url) { result in
            switch result {
            case .success(let image):
                if url == self.imageURL {
                    self.photoImage.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        // Get image from cache
        if let cachedImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString ) {
            print("Image from cache: ", url.lastPathComponent)
            completion(.success(cachedImage))
            return
        }
        
        // Dowonload image from url
        NetworkManager.shared.fetchImage(from: url.absoluteString) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
