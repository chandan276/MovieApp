//
//  MATableCellViewModel.swift
//  MovieApp
//
//  Created by Chandan Singh on 07/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import Foundation

class MATableCellViewModel: NSObject {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var movieId: Int {
        return movie.id
    }
    
    var movieTitle: String {
        return movie.title
    }
    
    var moviePosterPath: String {
        return movie.posterPath
    }
    
    var movieReleaseDate: String {
        return movie.releaseDate
    }
    
    var movieRating: Double {
        return movie.rating
    }
    
    var movieOverview: String {
        return movie.overview
    }
    
    var movieVoteCount: Int {
        return movie.voteCount
    }
    
    var movieIsAdult: Bool {
        return movie.isAdult
    }
}
