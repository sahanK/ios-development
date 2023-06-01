//
//  TLButtonView.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import SwiftUI

struct TLButtonView: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(backgroundColor)
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                    .padding(5)
            }
        }
        .padding(.vertical, 20)
    }
}

struct TLButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TLButtonView(
            title: "Login",
            backgroundColor: .blue
        ) {
            //
        }
    }
}
