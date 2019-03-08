//
//  MAMovieDetailCell.swift
//  MovieApp
//
//  Created by Chandan Singh on 06/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import UIKit

class MAMovieDetailCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseLabel: UILabel!
    @IBOutlet weak var movieVotesLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public var movieViewModel: MATableCellViewModel? {
        didSet {
            guard let movieViewModel = movieViewModel else { return }
            
            self.movieNameLabel.text = movieViewModel.movieTitle
            
            var adultStr = kNonAdultSign
            if (movieViewModel.movieIsAdult) {
                adultStr = kAdultSign
            }
            let formattedReleseString = String(format: "%@ | %@", adultStr, movieViewModel.movieReleaseDate)
            self.movieReleaseLabel.text = formattedReleseString
            
            let formattedVotesString = String(format: "%d %@", movieViewModel.movieVoteCount, kVotesString)
            self.movieVotesLabel.text = formattedVotesString
            
            self.movieOverviewLabel.text = movieViewModel.movieOverview
        }
    }
}
