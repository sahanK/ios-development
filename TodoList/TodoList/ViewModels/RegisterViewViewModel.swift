//
//  RegisterViewViewModel.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var emailAddress = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: emailAddress, password: password) { [weak self] result, error in
            guard let userId  = result?.user.uid, error == nil, let strongSelf = self else {
                return
            }
            strongSelf.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(
            id: id,
            name: name,
            email: emailAddress,
            joined: Date().timeIntervalSince1970
        )
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !emailAddress.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        guard emailAddress.contains("@"), emailAddress.contains(".") else {
            errorMessage = "please enter a valid email"
            return false
        }
        guard password.count >= 6 else {
            errorMessage = "Password should contains at least 6 characters"
            return false
        }
        return true
    }
}
