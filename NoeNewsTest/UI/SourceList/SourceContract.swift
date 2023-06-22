//
//  SourceContract.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import Foundation

protocol SourceRouterProtocol: AnyObject {
    func navigateToNewsList(source: String)
}

protocol SourcePresenterProtocol: AnyObject {
    var entity: SourceResponse? { get set }
    func getSourceByCategory(category: String)
    func navigateToNewsList(source: String)
    func viewDidLoad()
}

protocol SourceInteractorOutputProtocol: AnyObject {
    func onSourceSuccess(data: [Sources])
    func onSourceFailure(message: String)
    func onSourceEmpty()
}

protocol SourceInteractorInputProtocol: AnyObject {
    var output: SourceInteractorOutputProtocol? { get set }
    func getSourceByCategory(category: String)
}

protocol SourceViewProtocol: AnyObject {
    var presenter: SourcePresenterProtocol? { get set }
    func onSwhowLoading(show: Bool)
    func onSourceSuccess(data: [Sources])
    func onSourceFailure(message: String)
    func onSourceEmpty()
    
}
