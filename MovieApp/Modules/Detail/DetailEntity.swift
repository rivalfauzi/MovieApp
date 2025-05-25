//
//  DetailEntity.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

struct Review: Codable {
    let author: String?
    let content: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case author, content
        case createdAt = "created_at"
    }
}

struct ResponseReview: Codable {
    let results: [Review]?
}

struct VideoResponse: Codable {
    let results: [Video]?
}

struct Video: Codable {
    let id: String?
    let name: String?
    let key: String?
    let site: String?
    let type: String?
    let official: Bool?
}

