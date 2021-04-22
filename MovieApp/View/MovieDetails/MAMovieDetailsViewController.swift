//
//  MAMovieDetailsViewController.swift
//  MovieApp
//
//  Created by Chandan Singh on 21/04/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import UIKit
import SVProgressHUD

class MAMovieDetailsViewController: UIViewController {
    
    fileprivate let tableViewEstimatedRowHeight: CGFloat = 50.0
    fileprivate let parallaxImageHeight: CGFloat = 200.0
    fileprivate let parallaxImageStrechableHeight: CGFloat = 300.0
    fileprivate let similarMovieRowHeight: CGFloat = 140.0
    fileprivate let tableTopContentInset: CGFloat = 150.0
    fileprivate let sectionHeaderHeight: CGFloat = 30.0
    fileprivate let sectionCount = 2
    fileprivate let rowCountInSection = 1
    
    fileprivate var movieDataViewModel: MATableCellViewModel? = nil
    fileprivate let viewModel = MAMoviesViewModel()

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
        
        movieDetailsTableView.contentInset = UIEdgeInsets(top: tableTopContentInset, left: 0, bottom: 0, right: 0)
        
        movieDetailsTableView.register(UINib(nibName: CellConstants.movieDetailCellAndIdentifier, bundle: nil), forCellReuseIdentifier: CellConstants.movieDetailCellAndIdentifier)
        
        movieDetailsTableView.register(UINib(nibName: CellConstants.similarMovieCellAndIdentifier, bundle: nil), forCellReuseIdentifier: CellConstants.similarMovieCellAndIdentifier)
        
        moviePosterImageView.download(from: ImageSize.Original.rawValue + (self.movieDataViewModel?.moviePosterPath)!)
    }
    
    func setDetailData(_ data: MATableCellViewModel) -> Void {
        self.movieDataViewModel = data
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Network
    fileprivate func getSimilarMovieData() -> Void {
        viewModel.getSimilarMovies(movieId: movieDataViewModel?.movieId ?? 0) { [weak self] (error) in
            SVProgressHUD.show()
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                let sectionInAction = IndexSet(integersIn: 1...1)
                if error == nil {
                    self?.movieDetailsTableView.reloadSections(sectionInAction, with: .automatic)
                } else {
                    self?.movieDetailsTableView.deleteSections(sectionInAction, with: .automatic)
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
            
            guard let movieViewModel = movieDataViewModel else {
                return UITableViewCell()
            }
            cell.movieViewModel = movieViewModel
            cell.selectionStyle = .none
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.similarMovieCellAndIdentifier, for: indexPath) as? MASimilarMovieCell else {
                return UITableViewCell()
            }
            
            cell.delegate = self
            cell.setMovieData(viewModel)
            
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
            headerLabel.textColor = .black
            
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
        guard let data = viewModel.cellViewModel(index: selectedIndex) else {
            return
        }
        
        let movieDetailViewController = UIStoryboard.loadmovieDetailsViewController()
        movieDetailViewController.setDetailData(data)
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
