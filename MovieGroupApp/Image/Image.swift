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
        let poster_path: String
    }
    
    struct Book: Decodable {
        let documents: [Document]
    }
    struct Document: Decodable {
        let thumbnail: String
    }
    
}


