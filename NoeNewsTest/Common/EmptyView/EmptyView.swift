//
//  EmptyView.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import UIKit

protocol EmptyViewDelegate {
    func onClickRetry()
}

class EmptyView: UIView {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnRetry: UIButton!
    
    var delegate: EmptyViewDelegate?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialView()
    }

    override required init(frame: CGRect) {
        super.init(frame: frame)
        initialView()
    }

    func initialView() {
        Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showEmpty() {
        isHidden = false
        lblMessage.text = "No Data"
        btnRetry.isHidden = true
    }
    
    func showError(message: String) {
        isHidden = false
        lblMessage.text = message
        btnRetry.isHidden = false
    }
    
    @IBAction func doClickRetry(_ sender: Any) {
        delegate?.onClickRetry()
        isHidden = true
    }
    
}
