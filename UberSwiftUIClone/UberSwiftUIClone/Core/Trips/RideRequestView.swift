//
//  RideRequestView.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-23.
//

import SwiftUI

struct RideRequestView: View {
  
  // MARK: - PROPERTIES
  
  @State private var selectedRideType: RideType = .uberX
  @EnvironmentObject var locationViewModel: LocationSearchViewModel
  
  // MARK: - BODY
  
  var body: some View {
    VStack {
      Capsule()
        .foregroundColor(Color(.systemGray5))
        .frame(width: 48, height: 6)
        .padding(.top, 8)
      
      // MARK: - TRIP INFO VIEW
      HStack(spacing: 15) {
        VStack{
          Circle()
            .fill(.blue)
            .frame(width: 8, height: 8)
          Rectangle()
            .fill(.black)
            .frame(width: 1, height: 32)
          Rectangle()
            .fill(.black)
            .frame(width: 8, height: 8)
        }
        VStack(alignment: .leading, spacing: 36) {
          HStack {
            Text("Current location")
              .font(.system(size: 16, weight: .semibold))
              .foregroundColor(.gray)
            Spacer()
            Text(locationViewModel.pickupTime ?? "")
              .font(.system(size: 14, weight: .semibold))
              .foregroundColor(.gray)
          }//: HSTACK
          HStack {
            if let location = locationViewModel.selectedUberLocation {
              Text(location.title)
                .font(.system(size: 16, weight: .semibold))
            }
            Spacer()
            Text(locationViewModel.dropOffTime ?? "")
              .font(.system(size: 14, weight: .semibold))
              .foregroundColor(.gray)
          }//: HSTACK
        }//: VSTACK
      }//: HSTACK
      .padding()
      
      Divider()
      
      // MARK: - RIDE TYPE SELECTION VIEW
      
      Text("suggested rides".uppercased())
        .font(.subheadline)
        .fontWeight(.semibold)
        .padding()
        .foregroundColor(.gray)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(RideType.allCases) { rideType in
            VStack(alignment: .leading) {
              Image(rideType.imageName)
                .resizable()
                .scaledToFit()
                .scaleEffect(rideType == selectedRideType ? 1.2 : 1)
              VStack(alignment: .leading, spacing: 8) {
                Text(rideType.description)
                  .font(.system(size: 14, weight: .semibold))
                Text(locationViewModel.computePrice(for: rideType).toCurrency())
                  .font(.system(size: 14, weight: .semibold))
              }
              .foregroundColor(rideType == selectedRideType ? .white : .primary)
              .padding(16)
            }
            .frame(width: 120, height: 140)
            .background(rideType == selectedRideType ? .blue :  Color.theme.secondaryBackgroundColor)
            .cornerRadius(10)
            .onTapGesture {
              withAnimation(.spring()) {
                selectedRideType = rideType
              }
            }
          }
        }
      }//: SCROLLVIEW
      .padding(.horizontal)
      
      Divider()
        .padding(.vertical, 8)
      
      // MARK: - PAYMENT OPTION VIEW
      
      HStack() {
        Text("Visa")
          .font(.subheadline)
          .fontWeight(.semibold)
          .padding(6)
          .background(.blue)
          .cornerRadius(4)
          .foregroundColor(.white)
        Text("**** 1234")
          .fontWeight(.bold)
        Spacer()
        Image(systemName: "chevron.right")
          .imageScale(.medium)
      }
      .padding()
      .background(Color.theme.secondaryBackgroundColor)
      .cornerRadius(10)
      .padding(.horizontal)
      
      // MARK: - REQUEST RIDE BUTTON
      
      Button(action: {}, label: {
        Text("Confirm  Ride".uppercased())
          .fontWeight(.bold)
          .frame(width: UIScreen.main.bounds.width - 32, height: 50)
          .background(.blue)
          .cornerRadius(10)
          .foregroundColor(.white)
      })
    }//: VSTACK
    .padding(.bottom, 24)
    .background(Color.theme.backgroundColor)
    .cornerRadius(32)
  }//: BODY
}

struct RideRequestView_Previews: PreviewProvider {
  static var previews: some View {
    RideRequestView()
  }
}
