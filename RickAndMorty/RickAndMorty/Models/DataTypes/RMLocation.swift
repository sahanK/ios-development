//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by Sahan Walpita on 2023-02-14.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
