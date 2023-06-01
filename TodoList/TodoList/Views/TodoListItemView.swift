//
//  TodoListItemView.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import SwiftUI

struct TodoListItemView: View {
    @StateObject var viewModel = TodoListItemViewViewModel()
    let item: TodoListItemModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }

        }
    }
}

struct TodoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItemView(item: TodoListItemModel(
            id: "",
            title: "Workout",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: true
        ))
        .padding()
    }
}
