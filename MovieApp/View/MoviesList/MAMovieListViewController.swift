//
//  ViewController.swift
//  MovieApp
//
//  Created by Chandan Singh on 20/04/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import UIKit
import SVProgressHUD
import SVPullToRefresh

class MAMovieListViewController: UIViewController {
    
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    fileprivate var currentPage: Int = 1
    fileprivate let viewModel = MAMoviesViewModel()
    fileprivate var columnLayout = MAMovieColumnFlowLayout(cellsPerRow: 2)
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            columnLayout = MAMovieColumnFlowLayout(cellsPerRow: 3)
        }
        
        setupUI()
        getDataFromServer(currentPage)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: UI
    private func setupUI() -> Void {
        //Add Page title
        self.title = kHomeScreenTitle
        
        //Collectionview Layout
        movieListCollectionView.collectionViewLayout = columnLayout
        addShadowToCollectionView()
        addRefreshers()
    }
    
    private func addShadowToCollectionView() {
        movieListCollectionView.layer.shadowColor = UIColor.shadowColor.cgColor
        movieListCollectionView.layer.shadowOffset = CGSize(width: 0, height: 1)
        movieListCollectionView.layer.shadowOpacity = shadowOpacity
        movieListCollectionView.layer.shadowRadius = shadowRadius
    }
    
    private func addRefreshers() -> Void {
        self.movieListCollectionView.addPullToRefresh { [weak self] in
            self?.currentPage = 1
            self?.getDataFromServer(self?.currentPage ?? 1)
        }
        
        self.movieListCollectionView.addInfiniteScrolling { [weak self] in
            self?.currentPage += 1
            self?.getDataFromServer(self?.currentPage ?? 1)
        }
    }
    
    private func removeRefreshAnimators() -> Void {
        
        guard let refreshView = self.movieListCollectionView.pullToRefreshView else { return }
        guard let infiniteScrollView = self.movieListCollectionView.infiniteScrollingView else { return }
        
        refreshView.stopAnimating()
        infiniteScrollView.stopAnimating()
    }
    
    private func handleError(_ errorText: String) -> Void {
        movieListCollectionView.isHidden = true
        errorLabel.isHidden = false
        errorLabel.text = errorText
        
        refreshButton.isEnabled = true
    }
    
    private func handleUIForData() -> Void {
        movieListCollectionView.isHidden = false
        errorLabel.isHidden = true
        refreshButton.isEnabled = false
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        currentPage = 1
        getDataFromServer(currentPage)
    }
    
    //MARK: Network Call
    private func getDataFromServer(_ currentPage: Int) -> Void {
        SVProgressHUD.show()
        viewModel.getNowPlayingMovies(page: currentPage) { [weak self] (error) in
            DispatchQueue.main.async {
                self?.removeRefreshAnimators()
                SVProgressHUD.dismiss()
                if error == nil {
                    self?.handleUIForData()
                    self?.movieListCollectionView.reloadData()
                } else {
                    self?.handleError(error ?? kDownloadError)
                }
            }
        }
    }
}

extension MAMovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MAMovieCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! MAMovieCollectionCell
        
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        cell.viewModel = cellViewModel
        
        return cell
    }
}

extension MAMovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = viewModel.cellViewModel(index: indexPath.row) else {
            return
        }
        
        let movieDetailViewController = UIStoryboard.loadmovieDetailsViewController()
        movieDetailViewController.setDetailData(data)
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
