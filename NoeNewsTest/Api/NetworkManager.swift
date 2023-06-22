//
//  NetworkManager.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 21/06/23.
//

import Foundation
import Moya

class NetworkManager<T: BaseApi> {
    let ERROR_MESSAGE = "Internal Error"
    var provider: MoyaProvider<T>!

    func api() -> MoyaProvider<T> {
        provider = MoyaProvider<T>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
        return provider
    }
}
