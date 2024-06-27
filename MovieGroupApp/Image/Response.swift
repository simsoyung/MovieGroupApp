//
//  Response.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/25/24.
//

import Foundation
import Alamofire

class ResponseAPI {
    static let shared = ResponseAPI()
    private init() {}
    
    typealias CompletionHandlerMovie = ([Image.Result]?, String?) -> Void
    typealias CompletionHandlerBook = ([Image.Document]?, String?) -> Void
    
    
    func responseMovie(api: ImageRequest,completionHandler: @escaping CompletionHandlerMovie ){
        AF.request(api.endpoint,method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString) ,headers: api.movieHeader).responseDecodable(of: Image.Movie.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results, nil)
            case .failure(let error):
                completionHandler(nil, "검색어를 다시 입력해주세요")
            }
        }
    }
    
    func responseBook(api: ImageRequest ,completionHandler: @escaping CompletionHandlerBook ){
        AF.request(api.endpoint, method: api.method, parameters: api.parameter,encoding: URLEncoding(destination: .queryString) , headers: api.bookHeader).responseDecodable(of: Image.Book.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.documents, nil)
            case .failure(let error):
                completionHandler(nil, "검색어를 다시 입력해주세요")
            }
        }
    }

}

