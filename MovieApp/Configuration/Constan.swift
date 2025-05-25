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
    
    func url() -> String {
        return "\(BASE_URL)\(self.rawValue)"
    }
}
