//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Sahan Walpita on 2023-02-16.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
      let count: Int
      let pages: Int
      let next: String?
      let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}
