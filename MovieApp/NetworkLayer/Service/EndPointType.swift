//
//  EndPointType.swift
//  MovieApp
//
//  Created by Chandan Singh on 05/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
