//
//  User.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
