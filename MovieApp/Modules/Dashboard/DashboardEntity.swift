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
    var posterURL: String? {
        guard let path = posterPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(path)"
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
