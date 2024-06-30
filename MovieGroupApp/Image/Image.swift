//
//  Image.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/25/24.
//

import Foundation

enum Image {
    
    struct Movie: Decodable {
        let page: Int
        let results: [Result]
    }
    
    struct Result: Decodable {
        let poster_path: String?
        let id: Int
        let overview: String
        let backdrop_path: String?
        var posterImage: String {
            return poster_path == nil ? "https://picsum.photos/id/237/200/300": "\(poster_path!)"
        }
        var backdropImage: String {
            return backdrop_path == nil ? "https://picsum.photos/id/237/200/300": "\(backdrop_path!)"
        }
    }
    
    struct Book: Decodable {
        let documents: [Document]
    }
    struct Document: Decodable {
        let thumbnail: String?
        var thumbnailImage: String {
            return thumbnail == nil ? "https://picsum.photos/id/237/200/300": "\(thumbnail!)"
        }
    }
}



