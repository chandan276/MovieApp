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
    fileprivate let sectionCount = 2
    fileprivate let rowCountInSection = 1

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieDetailsTableView: UITableView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
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
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
            
            cell.movieNameLabel.text = "Total Dhamaal"
            cell.movieReleaseLabel.text = "06-03-2019"
            cell.movieVotesLabel.text = "1221 votes"
            cell.movieOverviewLabel.text = "Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal Total Dhamaal"
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.similarMovieCellAndIdentifier, for: indexPath) as? MASimilarMovieCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            
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
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
