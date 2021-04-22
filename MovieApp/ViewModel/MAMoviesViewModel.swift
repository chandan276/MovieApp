//
//  MAMoviesViewModel.swift
//  MovieApp
//
//  Created by Chandan Singh on 20/04/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import Foundation

class MAMoviesViewModel: NSObject {
    
    private let networkManager = NetworkManager()
    private var response: MovieApiResponse?
    private var movieData: [Movie] = [Movie]()
    
    public func getNowPlayingMovies(page: Int, completion: ((_ error: String?) -> Void)?) {
        
        networkManager.getNewMovies(page: page) { [weak self] (repos, error) in
            self?.response = repos
            self?.movieData += self?.response?.movies ?? [Movie]()
            completion?(error)
        }
    }
    
    public func getSimilarMovies(movieId: Int, completion: ((_ error: String?) -> Void)?) {
        networkManager.getSimilarMovies(movieId: movieId) { [weak self] (repos, error) in
            self?.response = repos
            self?.movieData = self?.response?.movies ?? [Movie]()
            completion?(error)
        }
    }
    
    public func cellViewModel(index: Int) -> MATableCellViewModel? {
        let cellModel = MATableCellViewModel(movie: self.movieData[index])
        return cellModel
    }
    
    public var count: Int {
        return movieData.count
    }
}
