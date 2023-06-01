//
//  CreateTodoView.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import SwiftUI

struct CreateTodoView: View {
    @StateObject var viewModel = CreateTodoViewViewModel()
    @Binding var createTodoPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            
            Form {
                TextField("Title", text: $viewModel.title)
                
                DatePicker("Due date", selection: $viewModel.dueDate)
                    .datePickerStyle(.graphical)
                
                TLButtonView(
                    title: "Save",
                    backgroundColor: .pink) {
                        if viewModel.canSave {
                            viewModel.save()
                            createTodoPresented = false 
                        } else {
                            viewModel.showAlert = true
                        }
                    }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Please fill in all fields and please select due date that is today or newer")
            )
        }
    }
}

struct CreateTodoView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTodoView(createTodoPresented: .constant(true))
    }
}
