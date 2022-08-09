//
//  LoadingConveniences.swift
//  ImdbList
//
//  Created by Danilo on 09/05/22.
//

import Foundation
import UIKit

class LoadingConvenience {
    
    static let shared = LoadingConvenience()
    
    private var loadingView: UIView!
    private var window = (UIApplication.shared.delegate!).window!
    
    static var blurView: UIVisualEffectView {
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.alpha = 0.95
        return view
    }
    
    static var shadowView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.5
        return view
    }
    
    static var activityIndicator: UIActivityIndicatorView {
        let loading = UIActivityIndicatorView(style: .whiteLarge)
        loading.color = .white
        return loading
    }
    
    // MARK: - Life Cycle
    init() {
        setupLoadingView()
    }
    
    // MARK: - Misc
    func enableFullScreenLoading() {
        window?.addSubview(loadingView)
    }
    
    func disableFullScreenLoading() {
        loadingView.removeFromSuperview()
    }
    
    private func setupLoadingView() {
        if let viewRect = window?.bounds {
            loadingView = UIView(frame: viewRect)
            loadingView.startLoading()
        }
    }
}
