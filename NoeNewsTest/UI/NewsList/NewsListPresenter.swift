//
//  NewsListPresenter.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import Foundation
class NewsListPresenter: NewsListPresenterProtocol {
    weak private var view: NewsListViewProtocol?
    private let interactor: NewsListInteractorInputProtocol?
    private let router: NewsListRouterProtocol?
    
    var entity: NewsListResponse?
    
    init(interface: NewsListViewProtocol, interactor: NewsListInteractorInputProtocol?, router: NewsListRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        interface.presenter = self
        interactor?.output = (self as NewsListInteractorOutputProtocol)
    }
    func getArticleByCategory(isloadMore: Bool, page: Int, source: String, q: String) {
        if !isloadMore {
            view?.onSwhowLoading(show: true)
        }
        interactor?.getArticleByCategory(isloadMore: isloadMore, page: page, source: source, q: q)
    }
    
    func navigateToShowArticle(url: String) {
        router?.navigateToShowArticle(url: url)
    }
    
    func viewDidLoad() {
        
    }
}

extension NewsListPresenter: NewsListInteractorOutputProtocol {
    func onNewsListSuccess(isloadMore: Bool, data: [NewsListData], page: Int) {
        if !isloadMore {
            view?.onSwhowLoading(show: false)
            view?.onArticleSuccess(data: data)
        } else {
            view?.onArticleSuccessLoadMore(data: data, page: page)
        }
    }
    
    func onNewsListFailure(isloadMore: Bool, message: String) {
        if !isloadMore {
            view?.onSwhowLoading(show: false)
            view?.onArticleFailure(message: message)
        } else {
            view?.onArticleFailureLoadMore(message: message)
        }
    }
    
    func onNewsListEmpty(isloadMore: Bool) {
        if !isloadMore {
            view?.onSwhowLoading(show: false)
            view?.onArticleEmpty()
        } else {
            view?.onArticleEmptyLoadMore()
        }
    }
}
