//
//  Constan.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

let BASE_URL = "https://api.themoviedb.org/3/"
let TOKEN = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YTZlMDgzZTlmMjE3NjVmYTAzMTAwNGZkZjk4OGRkOCIsIm5iZiI6MTcwODQwMjQ5Ni4yMDYsInN1YiI6IjY1ZDQyNzQwNDk4YmMyMDE3YTcxOTU2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4U8vLoO-1c5KbUFCvuFhVrUorfHgGyaYB04E3qBd75I"

enum MovieURL: String {
    case gettrendinglist = "trending/all/day"
    case nowplaying = "movie/now_playing"
    case detail = "movie/"
    case review = "movie/{movie_id}/reviews"
    case video = "movie/{movie_id}/videos"
    
    func url() -> String {
        return "\(BASE_URL)\(self.rawValue)"
    }
    
    func url(_ movieId: Int) -> String {
        switch self {
        case .review:
            return "\(BASE_URL)movie/\(movieId)/reviews"
        case .detail:
            return "\(BASE_URL)movie/\(movieId)"
        case .video:
            return "\(BASE_URL)movie/\(movieId)/videos"
        default:
            return url()
        }
    }
}
