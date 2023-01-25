//
//  MapViewActionButton.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-18.
//

import SwiftUI

struct MapViewActionButton: View {
  // MARK: - PROPERTIES
  
  @Binding var mapState: MapViewState
  @EnvironmentObject var viewModel: LocationSearchViewModel
  
  // MARK: - FUNCTIONS
  
  func actionForState(_ state: MapViewState) {
    switch state {
      case .noInput:
        print("DEBUG: Not input")
      case .locationSelected, .polylineAdded:
        mapState = .noInput
      case .searchingForLocation:
        viewModel.selectedUberLocation = nil
        mapState = .noInput
    }
  }
  
  func imageNameForState(_ state: MapViewState) -> String {
    switch state {
      case .noInput:
        return "line.3.horizontal"
      case .locationSelected, .searchingForLocation, .polylineAdded:
        return "arrow.left"
      default:
        return "line.3.horizontal"
    }
  }
  
  // MARK: - BODY
  
  var body: some View {
    Button(action: {
      withAnimation(.spring()) {
        actionForState(mapState)
      }
    }, label: {
      Image(systemName: imageNameForState(mapState))
        .font(.title3)
        .frame(width: 20, height: 20)
        .foregroundColor(.black)
        .padding()
        .background(.white)
        .clipShape(Circle())
        .shadow(color: .gray.opacity(0.5), radius: 15)
    })//: BUTTON
    .frame(maxWidth: .infinity, alignment: .leading)
  }//: BODY
}

// MARK: - PREVIEW

struct MapViewActionButton_Previews: PreviewProvider {
  static var previews: some View {
    MapViewActionButton(mapState: .constant(.locationSelected))
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
