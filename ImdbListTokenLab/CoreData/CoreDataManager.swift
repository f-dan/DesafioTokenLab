//
//  ViewController+CoreData.swift
//  ImdbList
//
//  Created by Danilo on 08/08/22.
//

import UIKit
import CoreData
import Foundation

final class CoreDataManager {
    var movieData: MovieData
    var descriptionData: DescriptionData
    var viewModel: MoviesListViewModel!
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    init(movieData: MovieData, descriptionData: DescriptionData){
        self.movieData = movieData
        self.descriptionData = descriptionData
        
    }
    
    func getCache(_ movies: [Movie]?, _ description: Description?) {
        if let movies = movies {
            movieData = MovieData(context: context)
            for movie in movies {
                let newMovie = NSEntityDescription.insertNewObject(forEntityName: "MovieData", into: context)
                newMovie.setValue(movie.id, forKey: "id")
                newMovie.setValue(movie.posterURL, forKey: "posterURL")
                newMovie.setValue(movie.releaseDate, forKey: "releaseDate")
                newMovie.setValue(movie.title, forKey: "title")
                newMovie.setValue(movie.genres, forKey: "genres")
                newMovie.setValue(movie.voteAverage, forKey: "voteAverage")
            }
        } else {
            guard let description = description else { return }
            descriptionData = DescriptionData(context: context)
            let newDescription = NSEntityDescription.insertNewObject(forEntityName: "DescriptionData", into: context)
            newDescription.setValue(description.releaseDate, forKey: "releaseDate")
            newDescription.setValue(description.overview, forKey: "overview")
            newDescription.setValue(description.posterURL, forKey: "posterURL")
            newDescription.setValue(description.title, forKey: "title")
            newDescription.setValue(description.adult, forKey: "adult")
            newDescription.setValue(description.backdropURL, forKey: "backdropURL")
            newDescription.setValue(description.belongsToCollection, forKey: "belongsToCollection")
            newDescription.setValue(description.budget, forKey: "budget")
            newDescription.setValue(description.genres, forKey: "genres")
            newDescription.setValue(description.homepage, forKey: "homepage")
            newDescription.setValue(description.id, forKey: "id")
            newDescription.setValue(description.imdbID, forKey: "imdbID")
            newDescription.setValue(description.originalTitle, forKey: "originalTitle")
            newDescription.setValue(description.originalLanguage, forKey: "originalLanguage")
            newDescription.setValue(description.popularity, forKey: "popularity")
            newDescription.setValue(description.productionCompanies, forKey: "productionCompanies")
            newDescription.setValue(description.productionCountries, forKey: "productionCountries")
            newDescription.setValue(description.revenue, forKey: "revenue")
            newDescription.setValue(description.runtime, forKey: "runtime")
            newDescription.setValue(description.spokenLanguages, forKey: "spokenLanguages")
            newDescription.setValue(description.status, forKey: "status")
            newDescription.setValue(description.tagline, forKey: "tagline")
            newDescription.setValue(description.video, forKey: "video")
            newDescription.setValue(description.voteAverage, forKey: "voteAverage")
            newDescription.setValue(description.voteCount, forKey: "voteCount")
        }
        do {
            try context.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func loadCache(movie: [Movie]?, description: Description?) {
        if let movie = movie {
            let fetchMovie: NSFetchRequest<MovieData> = MovieData.fetchRequest()
            let sortByVote = NSSortDescriptor(key: "voteAverage", ascending: false)
            fetchMovie.sortDescriptors = [sortByVote]
            do {
                let result = try context.fetch(fetchMovie)
                viewModel.currentResult = result as? [Movie]
            } catch let error as NSError {
                print("Fetch error: \(error) description: \(error.userInfo)")
            }
        } else {
            if let description = description {
                let fetchOverview: NSFetchRequest<DescriptionData> = DescriptionData.fetchRequest()
                do {
                    let result = try context.fetch(fetchOverview)
                    viewModel.description = result as? Description
                } catch let error as NSError {
                    print("Fetch error: \(error) description: \(error.userInfo)")
                }
            }
        }
    }
}
