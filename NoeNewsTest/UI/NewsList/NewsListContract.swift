//
//  NewsListContract.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import Foundation
protocol NewsListRouterProtocol: AnyObject {
    func navigateToShowArticle(url: String)
}

protocol NewsListPresenterProtocol: AnyObject {
    var entity: NewsListResponse? { get set }
    func getArticleByCategory(isloadMore: Bool, page: Int, source: String, q: String)
    func navigateToShowArticle(url: String)
    func viewDidLoad()
}

protocol NewsListInteractorOutputProtocol: AnyObject {
    func onNewsListSuccess(isloadMore: Bool, data: [NewsListData], page: Int)
    func onNewsListFailure(isloadMore: Bool, message: String)
    func onNewsListEmpty(isloadMore: Bool)
}

protocol NewsListInteractorInputProtocol: AnyObject {
    var output: NewsListInteractorOutputProtocol? { get set }
    func getArticleByCategory(isloadMore: Bool, page: Int, source: String, q: String)
}

protocol NewsListViewProtocol: AnyObject {
    var presenter: NewsListPresenterProtocol? { get set }
    func onArticleSuccess(data: [NewsListData])
    func onArticleSuccessLoadMore(data: [NewsListData], page: Int)
    func onSwhowLoading(show: Bool)
    func onLoadMoreLoading(show: Bool)
    func onArticleFailure(message: String)
    func onArticleFailureLoadMore(message: String)
    func onArticleEmpty()
    func onArticleEmptyLoadMore()
}
