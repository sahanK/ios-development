//
//  TodoListItemViewViewModel.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class TodoListItemViewViewModel: ObservableObject {
    init() {}
    
    func toggleIsDone(item: TodoListItemModel) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
