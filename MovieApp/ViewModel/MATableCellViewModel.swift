//
//  MATableCellViewModel.swift
//  MovieApp
//
//  Created by Chandan Singh on 20/04/21.
//  Copyright © 2021 Personal. All rights reserved.
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
