//
//  Search.swift
//  ImdbList
//
//  Created by Danilo on 03/05/22.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let voteAverage: Double
    let title: String
    let posterURL: String
    let genres: [String]
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case voteAverage = "vote_average"
        case title
        case posterURL = "poster_url"
        case genres
        case releaseDate = "release_date"
    }
}
