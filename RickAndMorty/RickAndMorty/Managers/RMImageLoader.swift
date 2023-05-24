//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Sahan Walpita on 2023-03-20.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private let imageDataCache = NSCache<NSString, NSData>()
    
    private init() {
        
    }
    
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let cacheKey = url.absoluteString as NSString // NSString = String
        if let data = imageDataCache.object(forKey: cacheKey) {
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            let cacheValue = data as NSData // NSData = Data
            self?.imageDataCache.setObject(cacheValue, forKey: cacheKey)
            completion(.success(data))
        }
        dataTask.resume()
    }
}
