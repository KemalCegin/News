//
//  NetworkManager.swift
//  News
//
//  Created by Kemal Cegin on 4.01.2023.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    private let baseUrl       = "https://newsapi.org/v2/"
    private let USTopHeadline = "top-headlines?country=us"
    
    func getArticles(for category: String? = nil, completed: @escaping ( Result<[News], APIErrors>) -> Void) {
        let endpoint = category == nil ? "\(baseUrl)\(USTopHeadline)&apiKey=\(APIKey.key)" : "\(baseUrl)top-headlines?country=us&category=\(category!)&apiKey=\(APIKey.key)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.unableToComplete))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let newsEnvelope = try decoder.decode(NewsEnvelope.self, from: data)
                completed(.success(newsEnvelope.articles))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
}




/*guard let url = URL(string: endpoint) else {
    
    return
}

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    guard error == nil, let data = data else {
        completion(nil)
        return
    }
    let newsEnvelope = try? JSONDecoder().decode(NewsEnvelope.self, from: data)
    newsEnvelope == nil ? completion(nil) : completion(newsEnvelope?.articles)
*/
