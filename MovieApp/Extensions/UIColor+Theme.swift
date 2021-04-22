//
//  UIColor+Theme.swift
//  MovieApp
//
//  Created by Chandan Singh on 21/04/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: Private
    fileprivate static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    fileprivate static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return rgba(r, g, b, 1.0)
    }
    
    // MARK: Public
    static let borderColor = UIColor.red
    static let shadowColor = UIColor.black
    static let refresherSpinnerColor = UIColor.black
}
