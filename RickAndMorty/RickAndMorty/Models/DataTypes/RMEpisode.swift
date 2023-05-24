//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Sahan Walpita on 2023-02-14.
//

import Foundation

struct RMEpisode: Codable, RMEpisodeDataRender {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
