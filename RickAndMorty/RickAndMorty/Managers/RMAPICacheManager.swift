//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by Sahan Walpita on 2023-04-04.
//

import Foundation

final class RMAPICacheManager {
    
    private var cacheDictionary: [
        RMEndooint: NSCache<NSString, NSData>
    ] = [:]
    
    init() {
        setupCache()
    }
    
    private func setupCache() {
        RMEndooint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
    
    public func cachedResponse(for endpoint: RMEndooint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint],
              let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: RMEndooint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint],
              let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
}
