//
//  NewsImageView.swift
//  News
//
//  Created by Kemal Cegin on 4.01.2023.
//

import UIKit

class NewsImageView: UIImageView {
    let cache = NetworkManager.shared.cache
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        layer.cornerRadius = 20
        clipsToBounds      = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
    }
    
    
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }

        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response: \(response)")
                return
            }
            guard let data = data else {
                print("No data returned")
                return
            }

            guard let image = UIImage(data: data) else {
                print("Unable to create image from data")
                return
            }
            self.cache.setObject(image, forKey: cacheKey)

            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }



}
