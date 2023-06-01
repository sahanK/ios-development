//
//  HeaderView.swift
//  TodoList
//
//  Created by Sahan Walpita on 2023-05-24.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let angle: Double
    let backgroundColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(backgroundColor)
                .rotationEffect(.degrees(angle))
            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .bold()
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .padding(.top, 80)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -150)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(
            title: "Todo List",
            subtitle: "Get things done",
            angle: 15,
            backgroundColor: .pink
        )
    }
}
