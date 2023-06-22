//
//  NewsListInteractor.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import Foundation
class NewsListInteractor: NewsListInteractorInputProtocol {
    var output: NewsListInteractorOutputProtocol?
    var provider = NetworkManager<Api>().api()
    
    func getArticleByCategory(isloadMore: Bool, page: Int, source: String, q: String) {
        provider.request(.getArticle(page: page, pageSize: 10, sources: source, q: q)) { result in
            switch result {
            case .success(let response):
                guard let obj = ResponseParser.shared.parse(to: NewsListResponse.self, from: response) else {
                    self.output?.onNewsListFailure(isloadMore: isloadMore, message: "internal error")
                    return
                }
                if obj.status == "error" {
                    self.output?.onNewsListFailure(isloadMore: isloadMore, message: obj.message ?? "internal error")
                } else {
                    if let data = obj.articles, data.count > 0 {
                        self.output?.onNewsListSuccess(isloadMore: isloadMore, data: data, page: page + 1)
                    } else {
                        self.output?.onNewsListEmpty(isloadMore: isloadMore)
                    }
                }
            case .failure(let err):
                self.output?.onNewsListFailure(isloadMore: isloadMore, message: err.localizedDescription)
            }
        }
    }

}
