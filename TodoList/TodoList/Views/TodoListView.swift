//
//  TodoListItemView.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct TodoListView: View {
    @StateObject var viewModel: TodoListViewViewModel
    @FirestoreQuery var items: [TodoListItemModel]
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(wrappedValue: TodoListViewViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    TodoListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Todo List")
            .toolbar {
                Button {
                    viewModel.displayCreateTodoView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.displayCreateTodoView) {
                CreateTodoView(createTodoPresented: $viewModel.displayCreateTodoView)
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(userId: "8ObjjwqomTcVhUaTJWhKqP32kbf2")
    }
}
