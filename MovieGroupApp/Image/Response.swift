//
//  Response.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/25/24.
//

import Foundation
import Alamofire
import XMLCoder

class ResponseAPI {
    static let shared = ResponseAPI()
    private init() {}
    
    func responseAPI<T: Decodable>(api: ImageRequest,headerStr: HeaderAPI, model: T.Type, completionHandler: @escaping (T? ,String?) -> Void) {
        AF.request(api.endpoint,method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString) ,headers: headerStr.headerKey).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(_):
                completionHandler(nil, "검색어를 다시 입력해주세요")
            }
        }
    }
}

