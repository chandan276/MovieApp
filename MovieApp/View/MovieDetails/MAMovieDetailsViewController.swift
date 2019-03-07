//
//  MAMovieDetailsViewController.swift
//  MovieApp
//
//  Created by Chandan Singh on 04/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import UIKit

class MAMovieDetailsViewController: UIViewController {
    
    fileprivate let tableViewEstimatedRowHeight: CGFloat = 200.0
    fileprivate let parallaxImageHeight: CGFloat = 200.0
    fileprivate let parallaxImageStrechableHeight: CGFloat = 300.0
    fileprivate let similarMovieRowHeight: CGFloat = 140.0
    fileprivate let sectionHeaderHeight: CGFloat = 30.0
    fileprivate let sectionCount = 2
    fileprivate let rowCountInSection = 1
    
    fileprivate let networkManager = NetworkManager()
    fileprivate var movieData: Movie? = nil
    fileprivate var similarMovieData: [Movie] = [Movie]()

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieDetailsTableView: UITableView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
        getSimilarMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: UI
    private func setupUI() -> Void {
        movieDetailsTableView.estimatedRowHeight = tableViewEstimatedRowHeight
        movieDetailsTableView.contentInset = UIEdgeInsets(top: moviePosterImageView.frame.size.height, left: 0, bottom: 0, right: 0)
        
        movieDetailsTableView.register(UINib(nibName: CellConstants.movieDetailCellAndIdentifier, bundle: nil), forCellReuseIdentifier: CellConstants.movieDetailCellAndIdentifier)
        
        movieDetailsTableView.register(UINib(nibName: CellConstants.similarMovieCellAndIdentifier, bundle: nil), forCellReuseIdentifier: CellConstants.similarMovieCellAndIdentifier)
        
        moviePosterImageView.download(from: ImageSize.Original.rawValue + (self.movieData?.posterPath)!)
    }
    
    func setImageDetailData(_ data:Movie) -> Void {
        self.movieData = data
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Network
    fileprivate func getSimilarMovieData() -> Void {
        networkManager.getSimilarMovies(movieId: movieData?.id ?? 0) { (movies, error) in
            DispatchQueue.main.async {
                if movies != nil {
                    self.similarMovieData.append(contentsOf: movies!)
                    let sectionToReload = IndexSet(integersIn: 1...1)
                    self.movieDetailsTableView.reloadSections(sectionToReload, with: .none)
                } else {
                    
                }
            }
        }
    }
}

extension MAMovieDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCountInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.movieDetailCellAndIdentifier, for: indexPath) as? MAMovieDetailCell else {
                return UITableViewCell()
            }
            
            cell.movieNameLabel.text = movieData?.title
            
            var adultStr = "U"
            if (movieData?.isAdult)! {
                adultStr = "A"
            }
            let formattedReleseString = String(format: "%@ | %@", adultStr, movieData?.releaseDate ?? "Today")
            cell.movieReleaseLabel.text = formattedReleseString
            
            let formattedVotesString = String(format: "%d votes", movieData?.voteCount ?? 0)
            cell.movieVotesLabel.text = formattedVotesString
            
            cell.movieOverviewLabel.text = movieData?.overview
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.similarMovieCellAndIdentifier, for: indexPath) as? MASimilarMovieCell else {
                return UITableViewCell()
            }
            
            cell.delegate = self
            cell.setMovieData(similarMovieData)
            
            return cell
        }
    }
}

extension MAMovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return similarMovieRowHeight
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return sectionHeaderHeight
        }
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerLabel = UILabel(frame: CGRect(x: 15, y: 0, width: self.view.frame.size.width, height: 20))
            headerLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            headerLabel.text = kSimilarMovieHeaderString
            
            let headerView = UILabel()
            headerView.addSubview(headerLabel)
            
            return headerView
        }
        return nil
    }
}

extension MAMovieDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = parallaxImageHeight - (scrollView.contentOffset.y + parallaxImageHeight)
        let height = min(max(y, 0), parallaxImageStrechableHeight)
        moviePosterImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
}

extension MAMovieDetailsViewController: MASimilarMovieProtocol {
    func selectedSimilarMovieFor(index selectedIndex: Int) -> Void {
        let movieDetailViewController = UIStoryboard.loadmovieDetailsViewController()
        movieDetailViewController.setImageDetailData(self.similarMovieData[selectedIndex])
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
