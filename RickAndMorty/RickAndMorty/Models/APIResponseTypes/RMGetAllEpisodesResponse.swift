//
//  RMGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Sahan Walpita on 2023-04-06.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    struct Info: Codable {
      let count: Int
      let pages: Int
      let next: String?
      let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
}
