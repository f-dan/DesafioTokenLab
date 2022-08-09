//
//  FailureScreenViewModel.swift
//  ImdbList
//
//  Created by Danilo on 06/08/22.
//

import Foundation
import UIKit

final class ErrorManager {
    static func display(navigation: UINavigationController?,
                        error: Error,
                        labelError: String? = "An error has occurred!",
                        lbButtonRetry: String = "Try again",
                        lbButtonCache: String = "Use cache",
                        buttonRetry: (() -> Void)? = nil,
                        buttonCache: (() -> Void)? = nil) {
        let view = FailureScreenViewController(lbError: labelError ?? error.localizedDescription, buttonAction: buttonRetry, buttonCache: buttonCache, lbButtonRetry: lbButtonRetry, lbButtonCache: lbButtonCache)
        if let topViewController = navigation?.topViewController, !(topViewController is FailureScreenViewController) {
            navigation?.pushViewController(view, animated: true)
        }
    }
    
    static func dismiss(navigation: UINavigationController?) {
        if let navigation = navigation, navigation.visibleViewController is FailureScreenViewController {
            navigation.popViewController(animated: false)
        }
    }
}
