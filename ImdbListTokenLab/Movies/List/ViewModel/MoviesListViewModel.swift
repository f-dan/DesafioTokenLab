//
//  ListMovieViewModel.swift
//  ImdbList
//
//  Created by Danilo on 11/05/22.
//

import Foundation
import UIKit
import CoreData

protocol MoviesListCoordinatorDelegate: AnyObject {
    func openDescriptionMovies(description: Description)
}

protocol MoviesListViewDelegate: AnyObject {
    func loading()
    func onSuccess()
    func onFailure(error: Error, retry: (() -> Void)?)
    func endLoading()
}

final class MoviesListViewModel {
    var currentResult: [Movie]?
    var description: Description!
    var coreDataManager: CoreDataManager!
    var movieData: MovieData
    var descriptionData: DescriptionData
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    weak var flowDelegate: MoviesListCoordinatorDelegate!
    weak var vcDelegate: MoviesListViewDelegate!
    private var service: ImdbAPI
    
    func countMovies()  -> Int {
        guard let currentResult = currentResult else { return 0 }
        return currentResult.count
    }
    
    init(service: ImdbAPI, movieData: MovieData, descriptionData: DescriptionData) {
        self.service = service
        self.movieData = movieData
        self.descriptionData = descriptionData
    }
    
    func movieBy(_ indexPath: IndexPath) ->  Movie? {
        if let currentResult = currentResult {
            return currentResult[indexPath.row]
        } else {
            return nil
        }
        
    }
    
    func goToMovieDescription(description: Description) {
        flowDelegate?.openDescriptionMovies(description: self.description)
    }
    
    func fetchList() {
        vcDelegate.loading()
        coreDataManager = CoreDataManager(movieData: movieData, descriptionData: descriptionData)
        service.requestList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.currentResult = movies
                self.coreDataManager.getCache(movies, nil)
                self.vcDelegate?.onSuccess()
            case .failure(let error):
                self.vcDelegate?.endLoading()
                self.coreDataManager.getCache(self.currentResult, nil)
                self.vcDelegate.onFailure(error: error, retry: {
                    self.fetchList()
                })
            }
        }
    }
    

    

    
    func fetchDescription(_ indexPath: IndexPath){
        vcDelegate.loading()
        coreDataManager = CoreDataManager(movieData: movieData, descriptionData: descriptionData)
        if let currentResult = currentResult {
            let id = currentResult[indexPath.row].id
            service.requestDescription(movieID: String(id)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let description):
                    self.description = description
                    self.coreDataManager.getCache(nil, description)
                    self.vcDelegate?.onSuccess()
                    self.goToMovieDescription(description: self.description)
                case .failure(let error):
                    self.vcDelegate?.endLoading()
                    self.coreDataManager.getCache(nil, self.description)
                    self.vcDelegate.onFailure(error: error, retry: {
                        self.fetchDescription(indexPath)
                    })
                }
            }
        }
    }
}
