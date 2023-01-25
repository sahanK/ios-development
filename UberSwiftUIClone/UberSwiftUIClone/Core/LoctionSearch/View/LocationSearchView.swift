//
//  LocationSearchView.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-18.
//

import SwiftUI

struct LocationSearchView: View {
  
  // MARK: - PROPERTIES
  @State private var currentLocation: String = ""
  @Binding var mapState: MapViewState
  @EnvironmentObject var viewModel: LocationSearchViewModel
  
  // MARK: - BODY
  
  var body: some View {
    VStack {
      // MARK: - HEADER
      
      HStack {
        VStack(alignment: .center) {
          Circle()
            .fill(.blue)
            .frame(width: 6, height: 6)
          Rectangle()
            .fill(.black)
            .frame(width: 1, height: 24)
          Rectangle()
            .fill(.black)
            .frame(width: 6, height: 6)
        }//: VSTACK
        VStack {
          TextField("Current Location", text: $currentLocation)
            .frame(height: 32)
            .background(
              RoundedRectangle(cornerRadius: 2)
                .fill(.thickMaterial)
            )
            .padding(.trailing)
          TextField("Where to?", text: $viewModel.queryFragment)
            .frame(height: 32)
            .background(
              RoundedRectangle(cornerRadius: 2)
                .fill(.thinMaterial)
            )
            .padding(.trailing)
        }//: VSTACK
      }//: HSTACK
      .padding(.top, 64)
      
      // MARK: - LOCATIONS
      
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          ForEach(viewModel.results, id: \.self) { result in
            LocationSearchResultCell(
              title: result.title,
              subtitle: result.subtitle
            )
            .onTapGesture {
              withAnimation(.spring()) {
                viewModel.selectLocation(result)
                mapState = .locationSelected
              }
            }
          }
        }//: VSTACK
      }//: SCROLLVIEW
    }//: VSATCK
    .padding(.horizontal)
  }//: BODY
}


// MARK: - PREVIEW

struct LocationSearchView_Previews: PreviewProvider {
  static var previews: some View {
    LocationSearchView(mapState: .constant(.locationSelected))
  }
}
