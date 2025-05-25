//
//  DashboardEntity.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]?
}

struct Movie: Codable {
    let id: Int
    let title: String?
    let overview: String?
    let posterPath: String?
    let voteAverage: Double?
    let backdropPath: String?
    let releaseDate: String?
    let runtime: Int?
    let genres: [Genre]?
    let homepage: String?
    let productionCompanies: [Company]?
    
    var posterURL: String? {
        guard let path = posterPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(path)"
    }
    
    var backdropURL: String? {
        guard let backdrop = backdropPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(backdrop)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres, homepage
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case productionCompanies = "production_companies"
    }
}

struct Genre: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

struct Company: Codable {
    let id: Int
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
