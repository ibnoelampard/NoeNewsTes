//
//  SourceListViewController.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import UIKit
import SkeletonView

class SourceViewController: UIViewController {
    class func instance(category: String) -> SourceViewController {
        let viewController = SourceViewController(nibName: "SourceViewController", bundle: nil)
        viewController.category = category
        return viewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: EmptyView!
    
    var presenter: SourcePresenterProtocol?
    var category: String?
    var dataList: [Sources]?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sources"
        initTableView()
        emptyView.delegate = self
        let router = SourceRouter()
        router.viewController = self
        presenter = SourcePresenter(interface: self, interactor: SourceInteractor(), router: router)
        presenter?.getSourceByCategory(category: category ?? "")
    }
    
    func initTableView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "GeneralTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralTableViewCell")
        tableView.reloadData()
    }
}

extension SourceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as! GeneralTableViewCell
        cell.selectionStyle = .none
        if let data = dataList?[indexPath.row] {
            cell.lblText.text = data.name
        }
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = dataList?[indexPath.row], let source = data.id {
            presenter?.navigateToNewsList(source: source)
        }
    }
}

extension SourceViewController: EmptyViewDelegate {
    func onClickRetry() {
        presenter?.getSourceByCategory(category: category ?? "")
    }
}

extension SourceViewController: SourceViewProtocol {
    func onSwhowLoading(show: Bool) {
        if show {
            tableView.showAnimatedSkeleton()
        } else {
            tableView.hideSkeleton()
        }
    }
    
    func onSourceSuccess(data: [Sources]) {
        dataList = data
        tableView.reloadData()
    }
    
    func onSourceFailure(message: String) {
        emptyView.showError(message: message)
    }
    
    func onSourceEmpty() {
        emptyView.showEmpty()
    }
}

// MARK: Shimmering Handler
extension SourceViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "GeneralTableViewCell"
    }
}
