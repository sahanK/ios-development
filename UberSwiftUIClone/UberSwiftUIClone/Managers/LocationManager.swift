//
//  LocationManager.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-18.
//

import CoreLocation

/// Responsible for requesting user location. Give the app permission to user location
class LocationManager: NSObject, ObservableObject {
  private let locationManager = CLLocationManager()
  static let shared = LocationManager()
  @Published var userLocation: CLLocationCoordinate2D?
  
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    self.userLocation = location.coordinate
    locationManager.stopUpdatingLocation()
  }
}
