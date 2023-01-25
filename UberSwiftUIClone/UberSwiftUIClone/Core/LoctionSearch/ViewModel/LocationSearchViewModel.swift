//
//  LocationSearchViewModel.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-19.
//

import Foundation
import MapKit

final class LocationSearchViewModel: NSObject, ObservableObject {
  
  // MARK: - PROPERTIES
  
  @Published var results = [MKLocalSearchCompletion]()
  @Published var selectedUberLocation: UberLocation?
  @Published var pickupTime: String?
  @Published var dropOffTime: String?
  
  private let searchCompleter = MKLocalSearchCompleter()
  var queryFragment: String = "" {
    didSet {
      searchCompleter.queryFragment = queryFragment
    }
  }
  
  var userLocation: CLLocationCoordinate2D?
  
  // MARK: - LIFECYCLE
  
  override init() {
    super.init()
    searchCompleter.delegate = self
    searchCompleter.queryFragment = queryFragment
  }
  
  // MARK: - HELPERS
  
  func selectLocation(_ localSearch: MKLocalSearchCompletion) {
    locationSearch(forLocalSearchCompletion: localSearch) { response, error in
      if let error = error {
        print("Location search failed with error \(error.localizedDescription)")
        return
      }
      guard let item = response?.mapItems.first else { return }
      let coordinate = item.placemark.coordinate
      self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
    }
  }
  
  func locationSearch(
    forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
    completion: @escaping MKLocalSearch.CompletionHandler
  ) {
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
    let search = MKLocalSearch(request: searchRequest)
    
    search.start(completionHandler: completion)
  }
  
  func computePrice(for rideType: RideType) -> Double {
    guard let destinationCoordinate = selectedUberLocation?.coordinate else { return 0.0 }
    guard let userCoordinate = self.userLocation else { return 0.0 }
    
    let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
    let destination = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
    let tripDistanceInMeters = userLocation.distance(from: destination)
    return rideType.computePrice(for: tripDistanceInMeters)
  }
  
  func getDestinationRoute(
    from userLocation: CLLocationCoordinate2D,
    to destination: CLLocationCoordinate2D,
    completion: @escaping(MKRoute) -> Void
  ) {
    let userPlacemark = MKPlacemark(coordinate: userLocation)
    let destinationPlacemark = MKPlacemark(coordinate: destination)
    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: userPlacemark)
    request.destination = MKMapItem(placemark: destinationPlacemark)
    let directions = MKDirections(request: request)
    
    directions.calculate { response, error in
      if let error = error {
        print("DEBUG: Failed to get directions with error \(error.localizedDescription)")
        return
      }
      guard let route = response?.routes.first else { return }
      self.confgurePickupAndDropOffTime(with: route.expectedTravelTime)
      completion(route)
    }
  }
  
  func confgurePickupAndDropOffTime(with expectedTravelTime: Double) {
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a"
    
    pickupTime = formatter.string(from: Date())
    dropOffTime = formatter.string(from: Date() + expectedTravelTime)
  }
}

// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    self.results = completer.results
  }
}
