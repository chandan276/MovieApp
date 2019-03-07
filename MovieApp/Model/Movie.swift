//
//  Movie.swift
//  MovieApp
//
//  Created by Chandan Singh on 05/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import Foundation

struct MovieApiResponse {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieApiResponse: Decodable {
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
}

struct Movie {
    let id: Int
    let posterPath: String
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
    let voteCount: Int
    let isAdult: Bool
}

extension Movie: Decodable {
    
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
        case voteCount = "vote_count"
        case isAdult = "adult"
    }
    
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try movieContainer.decode(Int.self, forKey: .id)
        posterPath = try movieContainer.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        title = try movieContainer.decode(String.self, forKey: .title)
        releaseDate = try movieContainer.decode(String.self, forKey: .releaseDate)
        rating = try movieContainer.decode(Double.self, forKey: .rating)
        overview = try movieContainer.decode(String.self, forKey: .overview)
        voteCount = try movieContainer.decode(Int.self, forKey: .voteCount)
        isAdult = try movieContainer.decode(Bool.self, forKey: .isAdult)
    }
}
