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
    case movieNum(query: String)
    case bookImage(query: String)
    case tvNum(query: String)
    
    var baseMovieURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .tvImage(let media, _) :
            return URL(string: baseMovieURL + "trending/\(media)/day?language=")!
        case .movieImage(let media, _) :
            return URL(string: baseMovieURL + "trending/\(media)/day?language=")!
        case .movieNum(let query):
            return URL(string: baseMovieURL + "movie/\(query)/recommendations")!
        case .bookImage:
            return URL(string: API.APIURL.kakaoBookURL)!
        case .tvNum(let query):
            return URL(string: baseMovieURL + "tv/\(query)/recommendations")!
        }
    }
    var movieHeader: HTTPHeaders {
        return ["Authorization": "\(API.APIKey.TMDBKey)"]
    }
    var bookHeader: HTTPHeaders {
        return ["Authorization": "\(API.APIKey.kakaoBookKey)"]
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
        case .movieNum(let query):
            return ["query": query]
        case .bookImage(let query):
            return ["query": query]
        case .tvNum(let query):
            return ["": ""]
        }
    }
    
}
