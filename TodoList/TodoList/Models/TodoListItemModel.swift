//
//  TodoListItemModel.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-26.
//

import Foundation

struct TodoListItemModel: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
