//
//  ViewController.swift
//  MovieApp
//
//  Created by Chandan Singh on 04/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import UIKit
import SVProgressHUD

class MAMovieListViewController: UIViewController {
    
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    fileprivate var refresher: UIRefreshControl!
    fileprivate var currentPage: Int = 1
    fileprivate let networkManager = NetworkManager()
    
    fileprivate var movieData: [Movie] = [Movie]()
    fileprivate var isWating: Bool = false
    
    let columnLayout = MAMovieColumnFlowLayout(
        cellsPerRow: 2,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        movieListCollectionView.contentInsetAdjustmentBehavior = .always
        
        //Add pull to refresh control to CollectionView
        self.refresher = UIRefreshControl()
        self.refresher.attributedTitle = NSAttributedString(string: kDataReloadString)
        self.movieListCollectionView.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.refresherSpinnerColor
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.movieListCollectionView.addSubview(refresher)
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
    
    @objc func loadData() {
        //code to execute during refresher
        currentPage = 1
        getDataFromServer(currentPage)
    }
    
    private func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        currentPage = 1
        getDataFromServer(currentPage)
    }
    
    //MARK: Network Call
    private func getDataFromServer(_ currentPage: Int) -> Void {
        SVProgressHUD.show()
        networkManager.getNewMovies(page: currentPage) { movies, error in
            DispatchQueue.main.async {
                self.stopRefresher()
                SVProgressHUD.dismiss()
                if movies != nil {
                    self.handleUIForData()
                    self.movieData.append(contentsOf: movies!)
                    self.movieListCollectionView.reloadData()
                } else {
                    self.handleError(error ?? kDownloadError)
                }
            }
        }
    }
}

extension MAMovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MAMovieCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! MAMovieCollectionCell
        
        let movie = movieData[indexPath.row]
        cell.photoImageView.download(from: ImageSize.Small.rawValue + movie.posterPath)
        
        return cell
    }
}

extension MAMovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailViewController = UIStoryboard.loadmovieDetailsViewController()
        movieDetailViewController.setImageDetailData(self.movieData[indexPath.row])
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.movieData.count - 2 && !isWating {
            isWating = true
            self.currentPage += 1
            self.doPaging()
        }
    }
    
    private func doPaging() {
        // call the API in this block and after getting the response then
        getDataFromServer(currentPage)
        self.isWating = false // it’s means paging is done and user can able request another page request by scrolling the collectionView at the bottom.
    }
}

