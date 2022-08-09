//
//  BaseCoordinator.swift
//  ImdbList
//
//  Created by Danilo on 09/05/22.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    associatedtype V: UIViewController
    var view: V? { get set }
    var navigation: UINavigationController! { get set }
    func start() -> V
    func stop()    
}
