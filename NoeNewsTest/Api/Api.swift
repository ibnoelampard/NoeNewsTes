//
//  Api.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 21/06/23.
//

import Foundation
import Moya
//https://newsapi.org/v2/top-headlines/sources?category=business&apiKey=8344394aec0e4d699be19bd65f8d6766
//https://newsapi.org/v2/top-headlines?q=companies&sources=bbc-news&page=1&pageSize=5&apiKey=8344394aec0e4d699be19bd65f8d6766
enum Api {
    case getSourceByCategory(category: String)
    case getArticle(page: Int, pageSize: Int, sources: String, q: String! = nil)
}

extension Api : BaseApi {
    var baseURL: URL {
        guard let url = URL(string: ApiConfig.BASE_URL) else { fatalError("Server in problem")}
        return url
    }
    
    var path: String {
        switch self {
        case .getSourceByCategory:
            return "/v2/top-headlines/sources"
        case .getArticle:
            return "/v2/top-headlines"
        }
    }
    
    var method: Moya.Method  {
        return .get
    }
    
    var parameters: [String : Any] {
        switch self {
        case let .getSourceByCategory(category):
            var parameters = [String: Any]()
            parameters["category"] = category
            parameters["apiKey"] = ApiKey
            return parameters
        case let .getArticle(page, pageSize, sources, q):
            var parameters = [String: Any]()
            parameters["page"] = page
            parameters["pageSize"] = pageSize
            parameters["sources"] = sources
            if q != nil {
                parameters["q"] = q
            }
            parameters["apiKey"] = ApiKey
            return parameters
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
}
