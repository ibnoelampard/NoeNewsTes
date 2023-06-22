//
//  ResponseParser.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 21/06/23.
//

import Foundation
import Moya

class ResponseParser {
    
    static let shared = ResponseParser()
    
    let decoder = JSONDecoder()
    
    func parse<ResponseType: Codable>(to: ResponseType.Type, from response: Moya.Response) -> ResponseType? {
        do {
            let response = try decoder.decode(ResponseType.self, from: response.data)
            return response
        }catch(let error) {
            print(error)
            return nil
        }
    }
}
