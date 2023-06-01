//
//  RegisterView.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        VStack {
            // HEADER
            HeaderView(
                title: "Register",
                subtitle: "Start organizing todos",
                angle: -15,
                backgroundColor: .orange
            )
            
            // FORM
            Form {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                TextField("Full name", text: $viewModel.name)
                TextField("Email address", text: $viewModel.emailAddress)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $viewModel.password)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                
                TLButtonView(
                    title: "Create account",
                    backgroundColor: .green
                ) {
                    viewModel.register()
                }
            }
            .offset(y: -50)
            
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
