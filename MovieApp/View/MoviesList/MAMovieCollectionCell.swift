//
//  MAMovieCollectionCell.swift
//  MovieApp
//
//  Created by Chandan Singh on 05/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import UIKit

class MAMovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public var viewModel: MATableCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.photoImageView.download(from: ImageSize.Small.rawValue + viewModel.moviePosterPath)
        }
    }
}
