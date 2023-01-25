//
//  LocationSearchResultCell.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-18.
//

import SwiftUI

struct LocationSearchResultCell: View {
  // MARK: - PROPERTIES
  
  let title: String
  let subtitle: String
  
  // MARK: - BODY
  
  var body: some View {
    HStack(alignment: .center, spacing: 16) {
      Image(systemName: "mappin.circle.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40)
        .foregroundColor(.blue)
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.body)
        Text(subtitle)
          .font(.subheadline)
          .foregroundColor(.secondary)
        Divider()
      }//: VSTACK
    }//: HSTACK
  }//: BODY
}

// MARK: - PREVIEW

struct LocationSearchResultCell_Previews: PreviewProvider {
  static var previews: some View {
    LocationSearchResultCell(title: "Starbuck Coffee", subtitle: "123 Main St, Cupertino CA")
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
