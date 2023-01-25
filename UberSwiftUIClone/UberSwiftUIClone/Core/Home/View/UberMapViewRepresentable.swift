//
//  UberMapViewRepresentable.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-18.
//

/// Allows us to create a view using UIKit and represent that view in SwiftUI
import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
  
  let mapView = MKMapView()
  @EnvironmentObject private var locationViewModel: LocationSearchViewModel
  @Binding var mapState: MapViewState
  
  func makeUIView(context: Context) -> some UIView {
    mapView.delegate = context.coordinator
    mapView.isRotateEnabled = false
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    
    return mapView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    switch mapState {
      case .noInput:
        context.coordinator.clearMapViewAndRecenterOnUserLocation()
        break
      case .locationSelected:
        if let coordinate = locationViewModel.selectedUberLocation?.coordinate {
          context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
          context.coordinator.configurePolyline(withDestination: coordinate)
        }
        break
      case .searchingForLocation:
        break
      case .polylineAdded:
        break
    }
  }
  
  // This is a required function of UIRepresentable protocol to make a coordinator
  // We make a coordinator from this function and it will be available in the makeUIView
  func makeCoordinator() -> MapCoordinator {
    return MapCoordinator(parent: self)
  }

}


extension UberMapViewRepresentable {

  class MapCoordinator: NSObject, MKMapViewDelegate {
    // MARK: - PROPERTIES
    
    let parent: UberMapViewRepresentable
    var userLocationCoordinate: CLLocationCoordinate2D?
    var currentRegion: MKCoordinateRegion?
    
    // MARK: - LIFECYCLE
    
    init(parent: UberMapViewRepresentable) {
      self.parent = parent
      super.init()
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
      let region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
          latitude: userLocation.coordinate.latitude,
          longitude: userLocation.coordinate.longitude
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
      )
      currentRegion = region
      userLocationCoordinate = userLocation.coordinate
      parent.mapView.setRegion(region, animated: true)
    }
    
    // Tell our map view to draw the overlay with the selected route
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let polyline = MKPolygonRenderer(overlay: overlay)
      polyline.strokeColor = .blue
      polyline.lineWidth = 6
      return polyline
    }
    
    // MARK: - HELPERS
    
    func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
      parent.mapView.removeAnnotations(parent.mapView.annotations)
      let annotation = MKPointAnnotation()
      annotation.coordinate = coordinate
      parent.mapView.addAnnotation(annotation)
      parent.mapView.selectAnnotation(annotation, animated: true)
    }
    
    func configurePolyline(withDestination coordinate: CLLocationCoordinate2D) {
      guard let userLocationCoordinate = userLocationCoordinate else { return }
      parent.locationViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
        self.parent.mapView.addOverlay(route.polyline)
        self.parent.mapState = .polylineAdded
        let rect = self.parent.mapView.mapRectThatFits(
          route.polyline.boundingMapRect,
          edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32)
        )
        self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
      }
    }
    
    func clearMapViewAndRecenterOnUserLocation() {
      parent.mapView.removeAnnotations(parent.mapView.annotations)
      parent.mapView.removeOverlays(parent.mapView.overlays)
      
      if let currentRegion = currentRegion {
        parent.mapView.setRegion(currentRegion, animated: true)
      }
    }
  }
}

