//
//  UIStoryboard+Loader.swift
//  MovieApp
//
//  Created by Chandan Singh on 21/04/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import UIKit

fileprivate enum Storyboard : String {
    case main = "Main"
}

fileprivate extension UIStoryboard {
    
    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }
    
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}

// MARK: App View Controllers

extension UIStoryboard {
    static func loadmovieDetailsViewController() -> MAMovieDetailsViewController {
        return loadFromMain("MAMovieDetailsViewController") as! MAMovieDetailsViewController
    }
}
