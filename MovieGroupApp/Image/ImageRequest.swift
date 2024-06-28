//
//  ImageRequest.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/26/24.
//

import Foundation
import Alamofire
import XMLCoder

enum ImageRequest {
    case tvImage(media: String, language: String)
    case movieImage(media: String, language: String)
    case movieNum(query: String, language: String)
    case bookImage(query: String)
    case tvNum(query: String,language: String)
    
    var baseMovieURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .tvImage(let media, _) :
            return URL(string: baseMovieURL + "trending/\(media)/day?language=")!
        case .movieImage(let media, _) :
            return URL(string: baseMovieURL + "trending/\(media)/day?language=")!
        case .movieNum(let query ,_):
            return URL(string: baseMovieURL + "movie/\(query)/recommendations?language=")!
        case .bookImage:
            return URL(string: API.APIURL.kakaoBookURL)!
        case .tvNum(let query, _):
            return URL(string: baseMovieURL + "tv/\(query)/recommendations?language=")!
        }
    
    }
    var method: HTTPMethod {
        return .get
    }
    var parameter: Parameters {
        switch self {
        case .tvImage(_, let language):
            return ["language": language ]
        case .movieImage(_, let language):
            return ["language": language ]
        case .movieNum(let query, let language ):
            return ["query": query, "language": language]
        case .bookImage(let query):
            return ["query": query]
        case .tvNum(_, let language):
            return ["language": language]
        }
    }
    
}

enum HeaderAPI {
    case movie
    case book
    var headerKey: HTTPHeaders {
        switch self {
        case .movie:
            return ["Authorization": "\(API.APIKey.TMDBKey)"]
        case .book:
            return ["Authorization": "\(API.APIKey.kakaoBookKey)"]
        }
    }
}
