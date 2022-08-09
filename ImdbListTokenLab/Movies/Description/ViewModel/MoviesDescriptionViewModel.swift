//
//  MoviesDescriptionViewModel.swift
//  ImdbList
//
//  Created by Danilo on 11/05/22.
//

import Foundation

final class MoviesDescriptionViewModel {
    
    var description: Description!
    private var service: ImdbAPI
    
    lazy var overview: String = {
        return description.overview
    }()
    
    lazy var title: String = {
        return description.title
    }()
    
    lazy var releaseDate: String = {
        return description.releaseDate
    }()
    
    lazy var image: URL = {
        let url = URL(string: description.posterURL)!
        return url
    }()
    
    init(service: ImdbAPI, description: Description) {
        self.service = service
        self.description = description
    }    
}
