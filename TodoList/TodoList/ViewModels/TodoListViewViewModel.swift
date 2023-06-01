//
//  TodoListViewViewModel.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import Foundation
import FirebaseFirestore

final class TodoListViewViewModel: ObservableObject {
    @Published var displayCreateTodoView = false
    
    private var userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    /// Delete Todo Item
    /// - Parameter id: Todo document id
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
