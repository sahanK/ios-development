//
//  TodoListApp.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import SwiftUI
import FirebaseCore

@main
struct TodoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
