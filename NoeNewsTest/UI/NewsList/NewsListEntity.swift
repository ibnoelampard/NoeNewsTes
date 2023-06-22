//
//  NewsListEntity.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 21/06/23.
//

import Foundation

struct NewsListResponse: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [NewsListData]?
    var message: String?
}

struct NewsListData: Codable {
    var urlToImage: String?
    var title: String?
    var description: String?
    var url: String?
}
