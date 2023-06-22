//
//  BaseApi.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 21/06/23.
//

import Foundation
import Moya

protocol BaseApi: TargetType {

    var baseURL: URL {
        get
    }

    var path: String {
        get
    }

    var method: Moya.Method {
        get
    }

    var sampleData: Data {
        get
    }

    var task: Task {
        get
    }

    var headers: [String : String]? {
        get
    }

}

extension TargetType {

    var sampleData: Data {
        return Data()
    }

    var baseURL: URL {
        guard let url = URL(string: "") else { fatalError("Server in problem") }
        return url
    }

    var path: String {
        return ""
    }

    var method: Moya.Method {
        return .get
    }

    var parameters: [String: Any] {
        return [:]
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }

    var headers: [String : String]? {
        return [:]
    }

}
