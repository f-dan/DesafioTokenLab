//
//  FailureScreenViewController.swift
//  ImdbList
//
//  Created by Danilo on 05/08/22.
//

import UIKit

class FailureScreenViewController: UIViewController {

    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var btCache: UIButton!
    @IBOutlet weak var btRetry: UIButton!
    
    var buttonAction: (() -> Void)? = nil
    var buttonCache: (() -> Void)? = nil
    var lbButtonRetry: String
    var lbButtonCache: String
    var lbErrorTeste: String
    
    init(lbError: String,
         buttonAction: (() -> Void)? = nil,
         buttonCache: (() -> Void)? = nil,
         lbButtonRetry: String,
         lbButtonCache: String) {
        self.lbErrorTeste = lbError
        self.buttonAction = buttonAction
        self.buttonCache = buttonCache
        self.lbButtonRetry = lbButtonRetry
        self.lbButtonCache = lbButtonCache
      
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbError.text = lbErrorTeste
        self.btCache.setTitle(lbButtonCache, for: .normal)
        self.btRetry.setTitle(lbButtonRetry, for: .normal)
    }
    
    @IBAction func btCache(_ sender: Any) {
        guard let buttonCache = buttonAction else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        self.view?.startLoading()
        buttonCache()
    }
    
    @IBAction func btRetry(_ sender: Any) {
        guard let buttonRetry  = buttonAction else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        self.view?.startLoading()
        buttonRetry()
    }
}
