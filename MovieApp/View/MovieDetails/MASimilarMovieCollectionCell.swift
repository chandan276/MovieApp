//
//  MASimilarMovieCollectionCell.swift
//  MovieApp
//
//  Created by Chandan Singh on 06/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import UIKit

class MASimilarMovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var similarMovieImageView: UIImageView!
    @IBOutlet weak var similarMovieNameLabel: UILabel!
    
    private let imageBorder: CGFloat = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.similarMovieImageView.layer.cornerRadius = self.similarMovieImageView.frame.size.width / 2;
        self.similarMovieImageView.layer.borderWidth = imageBorder
        self.similarMovieImageView.layer.borderColor = UIColor.borderColor.cgColor
    }
    
    public var viewModel: MATableCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            self.similarMovieImageView.download(from: ImageSize.Thumb.rawValue + viewModel.moviePosterPath)
            self.similarMovieNameLabel.text = viewModel.movieTitle
        }
    }
}
