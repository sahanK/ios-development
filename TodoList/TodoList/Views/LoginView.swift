//
//  LoginView.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // HEADER
                HeaderView(
                    title: "Todo List",
                    subtitle: "Get things done",
                    angle: 15,
                    backgroundColor: .pink
                )
                
                // LOGIN FORM
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    TextField("Email Address", text: $viewModel.emailAddress)
                        .textFieldStyle(.roundedBorder)
                        .padding(.top, 10)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                    
                    TLButtonView(
                        title: "Login",
                        backgroundColor: .blue
                    ) {
                        viewModel.login()
                    }
                }
                .offset(y: -50)
                
                // CREATE ACCOUNT
                VStack {
                    Text("New around here?")
                    NavigationLink("Create an account", destination: RegisterView())
                    .padding(.top, 10)
                }
                .padding(.vertical, 5)
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
