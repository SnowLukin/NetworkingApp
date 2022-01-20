//
//  ContactInfoViewController.swift
//  NetworkingApp
//
//  Created by Snow Lukin on 18.01.2022.
//

import UIKit

class PhotosViewController: UICollectionViewController {

    struct Constants {
        static let contactInfoUrl = "https://jsonplaceholder.typicode.com/photos"
    }
    
    private var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
}

// MARK: - Networking
extension PhotosViewController {
    private func fetch() {
        NetworkManager.shared.fetch(dataType: [Photo].self, from: Constants.contactInfoUrl) { result in
            switch result {
            case .success(let photos):
                self.photos = photos
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Collection View
extension PhotosViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if photos.isEmpty {
            return 0
        }
        
        var count = 0
        var previousID = -1
        photos.forEach { photo in
            if photo.albumId != previousID {
                count += 1
                previousID = photo.albumId
            }
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        // TODO: - New method needed with universality.
        // This filter only works in our case.
        photos.filter({ $0.albumId == section + 1 }).count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "photoCell",
            for: indexPath
        ) as! PhotoCell
        let photo = photos[indexPath.row]
        
        cell.configure(with: photo)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "photosHeader", for: indexPath) as! PhotoHeader
            header.sectionNameLabel.text = "Album №\(getAlbumIDForSection(indexPath.section + 1))"
            
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "photosFooter", for: indexPath)
            return footer
        default:
            fatalError()
        }
    }
    
    private func getAlbumIDForSection(_ repeatTimes: Int) -> Int {
        var count = 0
        var albumId = -1
        for photo in photos {
            if count == repeatTimes {
                break
            }
            if photo.albumId != albumId {
                count += 1
                albumId = photo.albumId
            }
        }
        
        return albumId
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = UIScreen.main.bounds.width / 3 - 2
        return CGSize(width: side, height: side)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
