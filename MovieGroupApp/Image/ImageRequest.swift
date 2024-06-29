//
//  ImageRequest.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/26/24.
//

import Foundation
import Alamofire

enum ImageRequest {
    case tvImage(media: String, language: String)
    case movieImage(media: String, language: String)
    case movieNum(query: String, language: String)
    case bookImage(query: String)
    case tvNum(query: String, language: String)
    case tvSearch(key: String, query: String)
    case movieSearch(key: String, query: String)
    
    var baseMovieURL: String {
        return "https://api.themoviedb.org/3/"
    }
    var endpoint: URL {
        switch self {
        case .tvImage(let media, let language) :
            return URL(string: baseMovieURL + "trending/\(media)/day?language=\(language)")!
        case .movieImage(let media, let language) :
            return URL(string: baseMovieURL + "trending/\(media)/day?language=\(language)")!
        case .movieNum(let query ,let language):
            return URL(string: baseMovieURL + "movie/\(query)/recommendations?language=\(language)")!
        case .bookImage:
            return URL(string: API.APIURL.kakaoBookURL)!
        case .tvNum(let query, let language):
            return URL(string: baseMovieURL + "tv/\(query)/recommendations?language=\(language)")!
        case .tvSearch(let key, let query):
            return URL(string: baseMovieURL + "search/tv?api_key=\(key)&language=ko-KR&page=1&query=\(query)")!
        case .movieSearch(let key, let query):
            return URL(string: baseMovieURL + "search/movie?api_key=\(key)&language=ko-KR&page=1&query=\(query)")!
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
        case .movieNum(let query, let language):
            return ["query": query, "language": language]
        case .bookImage(let query):
            return ["query": query]
        case .tvNum(let query, let language):
            return ["query": query, "language": language]
        case .tvSearch(let key, _):
            return ["": ""]
        case .movieSearch(let key, _):
            return ["": ""]
        }
    }
    
}
enum HeaderAPI {
    case movie
    case book
    case num
    var headerKey: HTTPHeaders {
        switch self {
        case .movie:
            return ["Authorization": "\(API.APIKey.TMDBKey)"]
        case .book:
            return ["Authorization": "\(API.APIKey.kakaoBookKey)"]
        case .num:
            return ["": ""]
        }
    }
}

