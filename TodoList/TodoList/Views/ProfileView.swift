//
//  ProfileView.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    ProgressView {
                        Text("Loading profile")
                    }
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fethcUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        Image(systemName: "person.circle")
            .resizable()
            .scaledToFit()
            .foregroundColor(.blue)
            .frame(width: 125, height: 125)
            .padding()
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            HStack {
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            HStack {
                Text("Member since: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
        }
        
        Button("Log out") {
            viewModel.logout()
        }
        .tint(.red)
        .padding()
        
        Spacer()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
