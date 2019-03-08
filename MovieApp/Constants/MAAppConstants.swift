//
//  MAAppConstants.swift
//  MovieApp
//
//  Created by Chandan Singh on 04/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import Foundation
import UIKit

struct CellConstants {
    static let movieDetailCellAndIdentifier = "MAMovieDetailCell"
    static let similarMovieCellAndIdentifier = "MASimilarMovieCell"
    static let similarMovieCollectionCellAndIdentifier = "MASimilarMovieCollectionCell"
}

enum ImageSize: String {
    case Thumb = "w92"
    case Small = "w185"
    case Original = "original"
}

let shadowRadius: CGFloat = 3.0
let shadowOpacity: Float = 1
