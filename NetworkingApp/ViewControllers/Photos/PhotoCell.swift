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
    
    override func prepareForReuse() {
        photoImage.image = UIImage(named: "defaultPhoto")
    }
    
    // MARK: Public methods
    func configure(with photo: Photo?) {
        DispatchQueue.global().async {
            guard let stringUrl = photo?.url else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.photoImage.image = UIImage(data: imageData)
            }
        }
    }
    
}
