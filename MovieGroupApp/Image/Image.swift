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
        var posterImage: String {
            return poster_path == nil ? "https://picsum.photos/id/237/200/300": "\(poster_path!)"
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
    
    struct Music: Decodable {
        let response: Response
    }
    struct Response: Decodable {
        let body: Body
    }
    struct Body: Decodable {
        let items: Items
    }
    struct Items: Decodable {
        let item: [Item]
    }
    struct Item: Decodable {
        let title: String
        let period: String
        let contactPoint: String
        let url: String
        let description: String
    }
}



