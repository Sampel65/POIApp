//
//  MapView.swift
//  POIApp
//
//  Created by Samson Oluwapelumi on 16/02/2025.
//


import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var annotations: [MKPointAnnotation]
    @Binding var selectedPlace: MKMapItem?
    @Binding var showPlaceDetail: Bool

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: false)
        mapView.showsUserLocation = true
        mapView.pointOfInterestFilter = .includingAll  
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(region, animated: true)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation as? MKPointAnnotation else { return }
            
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = annotation.title
            request.region = parent.region

            let search = MKLocalSearch(request: request)
            search.start { response, error in
                if let item = response?.mapItems.first {
                    DispatchQueue.main.async {
                        self.parent.selectedPlace = item
                        self.parent.showPlaceDetail = true
                    }
                }
            }
        }
    }
}
