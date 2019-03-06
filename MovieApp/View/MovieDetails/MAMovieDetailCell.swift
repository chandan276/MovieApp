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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
