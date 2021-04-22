//
//  MASimilarMovieCell.swift
//  MovieApp
//
//  Created by Chandan Singh on 20/04/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import UIKit

protocol MASimilarMovieProtocol: class {
    func selectedSimilarMovieFor(index selectedIndex: Int) -> Void
}

class MASimilarMovieCell: UITableViewCell {
    
    fileprivate var viewModel = MAMoviesViewModel()
    
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

    func setMovieData(_ movieData: MAMoviesViewModel) -> Void {
        self.viewModel = movieData
        self.similarMoviesCollectionView.reloadData()
    }
}

extension MASimilarMovieCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.similarMovieCollectionCellAndIdentifier, for: indexPath) as? MASimilarMovieCollectionCell else {
            return UICollectionViewCell()
        }
        
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        cell.viewModel = cellViewModel
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
