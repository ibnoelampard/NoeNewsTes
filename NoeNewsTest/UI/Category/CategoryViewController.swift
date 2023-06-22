//
//  CategoryViewController.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 21/06/23.
//

import UIKit

class CategoryViewController: UIViewController {
    class func instance() -> CategoryViewController {
        let viewController = CategoryViewController(nibName: "CategoryViewController", bundle: nil)
        return viewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataList: [String]? = ["business", "entertainment", "general", "health", "science", "sports", "technology"]

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        title = "News Category"
    }
    
    func initTableView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "GeneralTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralTableViewCell")
        tableView.reloadData()
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as! GeneralTableViewCell
        cell.selectionStyle = .none
        if let data = dataList?[indexPath.row] {
            cell.lblText.text = data
        }
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = dataList?[indexPath.row] {
            navigationController?.pushViewController(SourceViewController.instance(category: data), animated: true)
        }
    }
}
