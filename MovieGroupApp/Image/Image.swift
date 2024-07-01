//
//  Image.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/25/24.
//

import UIKit

enum Image {
    static let emptyImage = "https://images.pexels.com/photos/7564257/pexels-photo-7564257.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    
    struct Movie: Decodable {
        let page: Int
        let results: [Result]
    }
    
    struct Result: Decodable {
        let poster_path: String?
        let id: Int
        let name: String?
        let overview: String
        let title: String?
        let backdrop_path: String?
        var posterImage: String {
            return poster_path == nil ? "\(Image.emptyImage)": "https://image.tmdb.org/t/p/w500\(poster_path!)"
        }
        var backdropImage: String {
            return backdrop_path == nil ? "\(Image.emptyImage)": "https://image.tmdb.org/t/p/w500\(backdrop_path!)"
        }
    }
    
    struct Book: Decodable {
        let documents: [Document]
    }
    struct Document: Decodable {
        let thumbnail: String?
        let contents: String
        var thumbnailImage: String {
            return thumbnail == nil ? "\(Image.emptyImage)": "\(thumbnail!)"
        }
    }
}

enum Cast {
    struct MovieInfo: Decodable {
        let id: Int
        let cast: [Cast]
        let crew: [Crew]
    }
    struct Crew: Codable {
        let adult: Bool
        let gender: Int?
        let id: Int
        let knownForDepartment: String
        let name: String
        let originalName: String
        let popularity: Double
        let profilePath: String?
        let creditID: String
        let department: String
        let job: String
    }
    struct Cast: Codable {
        let adult: Bool
        let gender: Int?
        let id: Int
        let knownForDepartment: String
        let name: String
        let originalName: String
        let popularity: Double
        let profilePath: String?
        let castID: Int
        let character: String
        let creditID: String
        let order: Int
    }
}
