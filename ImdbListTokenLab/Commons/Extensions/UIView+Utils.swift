//
//  UIView+Utils.swift
//  ImdbList
//
//  Created by Danilo on 09/05/22.
//

import UIKit

public extension UIView {
    private static let loadingViewIdentifier = 5050
    
    func startLoading(_ shadow: Bool = true) {
        DispatchQueue.main.async {
            self.configureActivityIndicator()
        }
    }
    
    func configureActivityIndicator(_ shadow: Bool = true) {
        let loadingView = UIView()
        loadingView.frame = self.bounds
        loadingView.tag = UIView.loadingViewIdentifier
        
        let activityIndicator = LoadingConvenience.activityIndicator
        activityIndicator.frame = self.bounds
        activityIndicator.startAnimating()
        
        if shadow {
            let shadowView = LoadingConvenience.shadowView
            shadowView.frame = self.bounds
            loadingView.addSubview(shadowView)
        }
        
        loadingView.addSubview(activityIndicator)
        
        self.addSubview(loadingView)
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            let holderView = self.viewWithTag(UIView.loadingViewIdentifier)
            holderView?.removeFromSuperview()
        }
    }
    
}
