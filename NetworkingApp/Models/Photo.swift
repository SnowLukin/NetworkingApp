//
//  Photo.swift
//  NetworkingApp
//
//  Created by Snow Lukin on 20.01.2022.
//

struct Photo: Decodable {
    // more properties than needed in case of further app development
    // in current version following properties are being used:
    // albumID, url
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    
    init(photoData: [String: Any]) {
        albumId = photoData["albumId"] as? Int
        id = photoData["id"] as? Int
        title = photoData["title"] as? String
        url = photoData["url"] as? String
    }
    
    static func getPhotos(from value: Any) -> [Photo] {
        guard let photoData = value as? [[String: Any]] else { return [] }
        return photoData.compactMap { Photo(photoData: $0)}
    }
}
