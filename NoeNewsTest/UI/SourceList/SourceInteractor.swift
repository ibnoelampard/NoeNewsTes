//
//  SourceInteractor.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import Foundation

class SourceInteractor: SourceInteractorInputProtocol {
    
    var output: SourceInteractorOutputProtocol?
    var provider = NetworkManager<Api>().api()
    
    func getSourceByCategory(category: String) {
        provider.request(.getSourceByCategory(category: category)) { result in
            switch result {
            case .success(let response):
                guard let obj = ResponseParser.shared.parse(to: SourceResponse.self, from: response) else {
                    self.output?.onSourceFailure(message: "internal error")
                    return
                }
                if obj.status == "error" {
                    self.output?.onSourceFailure(message: obj.message ?? "internal error")
                } else {
                    if let data = obj.sources, data.count > 0 {
                        self.output?.onSourceSuccess(data: data)
                    } else {
                        self.output?.onSourceEmpty()
                    }
                }
            case .failure(let err):
                self.output?.onSourceFailure(message: err.localizedDescription)
            }
        }
    }
}
