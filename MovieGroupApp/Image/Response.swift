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
    func responseMovie(completionHandler: @escaping ([Image.Result]) -> Void ){
        let url = "\(API.APIURL.TMDBlanguageURL)"
        let parameter = ["query": "액션"]
        let header: HTTPHeaders = ["Authorization": "\(API.APIKey.TMDBKey)"]
        AF.request(url, parameters: parameter ,headers: header).responseDecodable(of: Image.Movie.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    func responseMovieIdNum(completionHandler: @escaping ([Image.Result]) -> Void ){
        let url = "https://api.themoviedb.org/3/movie/777/recommendations"
        let header: HTTPHeaders = ["Authorization": "\(API.APIKey.TMDBKey)"]
        AF.request(url, headers: header).responseDecodable(of: Image.Movie.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func responseBook(completionHandler: @escaping ([Image.Document]) -> Void ){
        let url = "\(API.APIURL.kakaoBookURL)"
        let header: HTTPHeaders = ["Authorization": "\(API.APIKey.kakaoBookKey)"]
        let parameter = ["query": "영화"]
        AF.request(url,parameters: parameter, headers: header).responseDecodable(of: Image.Book.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.documents)
            case .failure(let error):
                print(error)
            }
        }
    }

}

