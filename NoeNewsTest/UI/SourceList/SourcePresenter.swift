//
//  SourcePresenter.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import Foundation
class SourcePresenter: SourcePresenterProtocol {
    weak private var view: SourceViewProtocol?
    private let interactor: SourceInteractorInputProtocol?
    private let router: SourceRouterProtocol?
    
    var entity: SourceResponse?
    
    init(interface: SourceViewProtocol, interactor: SourceInteractorInputProtocol?, router: SourceRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        interface.presenter = self
        interactor?.output = (self as SourceInteractorOutputProtocol)
    }
    
    func getSourceByCategory(category: String) {
        view?.onSwhowLoading(show: true)
        interactor?.getSourceByCategory(category: category)
    }
    
    func navigateToNewsList(source: String) {
        router?.navigateToNewsList(source: source)
    }
    
    func viewDidLoad() {
        
    }
}

extension SourcePresenter: SourceInteractorOutputProtocol {
    func onSourceSuccess(data: [Sources]) {
        view?.onSwhowLoading(show: false)
        view?.onSourceSuccess(data: data)
    }
    
    func onSourceFailure(message: String) {
        view?.onSwhowLoading(show: false)
        view?.onSourceFailure(message: message)
    }
    
    func onSourceEmpty() {
        view?.onSwhowLoading(show: false)
        view?.onSourceEmpty()
    }
    
}
