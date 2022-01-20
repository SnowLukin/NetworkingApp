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
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
