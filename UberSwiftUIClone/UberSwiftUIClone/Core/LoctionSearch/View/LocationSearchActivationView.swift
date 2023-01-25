//
//  LocationSearchActivationView.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-18.
//

import SwiftUI

struct LocationSearchActivationView: View {
  
  // MARK: - BODY
  
  var body: some View {
    HStack {
      Circle()
        .fill(.black)
        .frame(width: 8, height: 8)
        .padding(.horizontal)
      Text("Where to?")
      Spacer()
    }//: HSTACK
    .frame(width: UIScreen.main.bounds.width - 30, height: 50)
    .background(
      RoundedRectangle(cornerRadius: 5)
        .fill(.white)
        .shadow(color: .gray.opacity(0.5), radius: 15, x: 6, y: 8)
    )
  }//: BODY
}

// MARK: - PREVIEW

struct LocationSearchActivationView_Previews: PreviewProvider {
  static var previews: some View {
    LocationSearchActivationView()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
