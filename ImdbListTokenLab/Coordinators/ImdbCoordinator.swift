//
//  ImdbCoordinator.swift
//  ImdbList
//
//  Created by Danilo on 09/05/22.
//

import Foundation
import UIKit

final class ImdbCoordinator: Coordinator {
    typealias V = MoviesListViewController
    var view: MoviesListViewController?
    var navigation: UINavigationController!
    
    func start() -> V {
        let viewModel = MoviesListViewModel(service: ImdbAPI(), movieData: MovieData(), descriptionData: DescriptionData())
        viewModel.flowDelegate = self
        view = MoviesListViewController(viewModel: viewModel)
        return view!
    }
    
    func stop() {
        view = nil
        navigation = nil
    }
    
    func openMoviesDescription(description: Description) {
        let moviesViewModel = MoviesDescriptionViewModel(service: ImdbAPI(), description: description)
        let trailerVc = MoviesDescriptionViewController(viewModel: moviesViewModel)
        trailerVc.modalPresentationStyle = .overFullScreen
        navigation.pushViewController(trailerVc, animated: true)
    }    
}


extension ImdbCoordinator: MoviesListCoordinatorDelegate {
    func openDescriptionMovies(description: Description) {
        openMoviesDescription(description: description)
    }
}
