//
//  UberSwiftUICloneApp.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-18.
//

import SwiftUI

@main
struct UberSwiftUICloneApp: App {
  @StateObject var locationViewModel = LocationSearchViewModel()
  
  var body: some Scene {
    WindowGroup {
      HomeView()
        .environmentObject(locationViewModel)
    }
  }
}
