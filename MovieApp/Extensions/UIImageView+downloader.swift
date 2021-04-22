//
//  UIImageView+downloader.swift
//  MovieApp
//
//  Created by Chandan Singh on 21/04/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import UIKit

extension UIImageView {
    func download(from url: URL) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func download(from link: String) {
        let formattedUrlString = MovieApi.images.imageBaseURL + link
        guard let url = URL(string: formattedUrlString) else { return }
        download(from: url)
    }
}
