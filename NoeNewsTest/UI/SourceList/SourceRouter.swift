//
//  SourceRouter.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import Foundation
class SourceRouter: SourceRouterProtocol {
    weak var viewController: SourceViewController?
    
    func navigateToNewsList(source: String) {
        let vc = NewsListViewController.instance(source: source)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
