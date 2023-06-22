//
//  NewsListRouter.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import Foundation
class NewsListRouter: NewsListRouterProtocol {
    
    weak var viewController: NewsListViewController?
    
    func navigateToShowArticle(url: String) {
        let vc = NewsDetailWebViewController.instance(url: url)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
