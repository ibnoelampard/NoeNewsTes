//
//  NewsListViewController.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 21/06/23.
//

import UIKit
import SkeletonView

class NewsListViewController: UIViewController {
    class func instance(source: String) -> NewsListViewController {
        let viewController = NewsListViewController(nibName: "NewsListViewController", bundle: nil)
        viewController.source = source
        return viewController
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: EmptyView!
    
    var presenter: NewsListPresenterProtocol?
    var searchActive : Bool = false
    var source: String?
    var dataList: [NewsListData]?
    var page = 1
    var isLoading = false
    var isDoneLoadMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Article"
        let router = NewsListRouter()
        router.viewController = self
        presenter = NewsListPresenter(interface: self, interactor: NewsListInteractor(), router: router)
        searchBar.delegate = self
        initTableView()
        presenter?.getArticleByCategory(isloadMore: false, page: page, source: source ?? "", q: searchBar.text ?? "")
    }

    func initTableView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsListCell", bundle: nil), forCellReuseIdentifier: "NewsListCell")
        tableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMoreCell")
        tableView.reloadData()
    }
}

extension NewsListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        presenter?.getArticleByCategory(isloadMore: false, page: page, source: source ?? "", q: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        page = 1
        presenter?.getArticleByCategory(isloadMore: false, page: page, source: source ?? "", q: searchBar.text ?? "")
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        var listCount = dataList?.count ?? 0
        if listCount > 0 {
            if !isDoneLoadMore {
                listCount += 1
            }
        }
        return listCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == dataList?.count ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell", for: indexPath) as! LoadMoreCell
            cell.selectionStyle = .none
            if !isLoading, !isDoneLoadMore {
                presenter?.getArticleByCategory(isloadMore: true, page: page, source: source ?? "", q: searchBar.text ?? "")
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListCell
            cell.selectionStyle = .none
            if let data = dataList?[indexPath.row] {
                cell.setData(imgUrl: data.urlToImage ?? "", title: data.title ?? "", description: data.description ?? "")
            }
            return cell
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = dataList?[indexPath.row], let url = data.url {
            presenter?.navigateToShowArticle(url: url)
        }
    }
}

extension NewsListViewController: EmptyViewDelegate {
    func onClickRetry() {
        page = 1
        presenter?.getArticleByCategory(isloadMore: false, page: page, source: source ?? "", q: searchBar.text ?? "")
    }
}

extension NewsListViewController: NewsListViewProtocol {
    func onArticleSuccess(data: [NewsListData]) {
        dataList = data
        isDoneLoadMore = false
        tableView.reloadData()
    }
    
    func onArticleSuccessLoadMore(data: [NewsListData], page: Int) {
        self.page = page
        if dataList == nil {
            dataList = []
        }
        dataList! += data
        tableView.reloadData()
    }
    
    func onSwhowLoading(show: Bool) {
        if show {
            tableView.showAnimatedSkeleton()
            isLoading = true
        } else {
            tableView.hideSkeleton()
            isLoading = false
        }
    }
    
    func onLoadMoreLoading(show: Bool) {
        if show {
            isLoading = true
        } else {
            isLoading = false
        }
    }
    
    func onArticleFailure(message: String) {
        emptyView.showError(message: message)
    }
    
    func onArticleFailureLoadMore(message: String) {}
    
    func onArticleEmpty() {
        emptyView.showEmpty()
        isDoneLoadMore = true
        tableView.reloadData()
    }
    
    func onArticleEmptyLoadMore() {
        isDoneLoadMore = true
        tableView.reloadData()
    }
}

// MARK: Shimmering Handler
extension NewsListViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "NewsListCell"
    }
}
