//
//  MASimilarMovieCell.swift
//  MovieApp
//
//  Created by Chandan Singh on 06/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import UIKit

protocol MASimilarMovieProtocol: class {
    func selectedSimilarMovieFor(index selectedIndex: Int) -> Void
}

class MASimilarMovieCell: UITableViewCell {
    
    fileprivate let imageBorder: CGFloat = 1.0
    
    @IBOutlet weak var similarMoviesCollectionView: UICollectionView!
    
    weak var delegate: MASimilarMovieProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.dataSource = self
        
        let cellNib = UINib(nibName: CellConstants.similarMovieCollectionCellAndIdentifier, bundle: nil)
        similarMoviesCollectionView.register(cellNib, forCellWithReuseIdentifier: CellConstants.similarMovieCollectionCellAndIdentifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension MASimilarMovieCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.similarMovieCollectionCellAndIdentifier, for: indexPath) as? MASimilarMovieCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.similarMovieImageView.layer.cornerRadius = cell.similarMovieImageView.frame.size.width / 2;
        cell.similarMovieImageView.layer.borderWidth = imageBorder
        cell.similarMovieImageView.layer.borderColor = UIColor.borderColor.cgColor
        
        return cell
    }
}

extension MASimilarMovieCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.selectedSimilarMovieFor(index: indexPath.row)
        }
    }
}
