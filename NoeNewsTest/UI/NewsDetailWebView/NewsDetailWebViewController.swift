//
//  NewsDetailWebViewController.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import UIKit
import WebKit

class NewsDetailWebViewController: UIViewController {
    class func instance(url: String) -> NewsDetailWebViewController {
        let viewController = NewsDetailWebViewController(nibName: "NewsDetailWebViewController", bundle: nil)
        viewController.url = url
        return viewController
    }
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var webview: WKWebView!
    var url: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail Article"
        webview.navigationDelegate = self
        loadingView.isHidden = false
        if let url = URL(string: url ?? "") {
            let request = URLRequest(url: url)
            webview.load(request)
        }
    }
}

extension NewsDetailWebViewController: WKNavigationDelegate {
    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        loadingView.isHidden = true
    }
}
