//
//  HomeView.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-18.
//

import SwiftUI

struct HomeView: View {
  // MARK: - PROPERTIES
  
  @State private var mapState = MapViewState.noInput
  @EnvironmentObject var locationViewModel: LocationSearchViewModel
  
  // MARK: - BODY
  
  var body: some View {
    ZStack(alignment: .bottom) {
      ZStack(alignment: .top) {
        UberMapViewRepresentable(mapState: $mapState)
          .ignoresSafeArea()
        
        if mapState == .searchingForLocation {
          LocationSearchView(mapState: $mapState)
            .background(Color.theme.backgroundColor)
        } else if mapState == .noInput {
          LocationSearchActivationView()
            .padding(.top, 72)
            .onTapGesture {
              withAnimation(.spring()) {
                mapState = .searchingForLocation
              }
            }
        }
        
        MapViewActionButton(mapState: $mapState)
          .padding(.leading, 10)
      }
      
      if (mapState == .locationSelected || mapState == .polylineAdded) {
        RideRequestView()
          .transition(.move(edge: .bottom))
      }
    }
    .edgesIgnoringSafeArea(.bottom)
    .onReceive(LocationManager.shared.$userLocation) { location in
      if let location = location {
        locationViewModel.userLocation = location
      }
    }
  }//: BODY
}

// MARK: - PREVIEW

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
