//
//  SourceListEntity.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import Foundation

struct SourceResponse: Codable {
    var status: String?
    var sources: [Sources]?
    var message: String?
}

struct Sources: Codable {
    var id: String?
    var name: String?
    var url: String!
}
