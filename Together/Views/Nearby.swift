//
//  NearbyView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI
import MapKit

struct Nearby: View {
    
    @ObservedObject private var warData = WarData()
    
    var body: some View {
        MapView(warData: warData)
            .edgesIgnoringSafeArea(.top)
    }
}

struct MapView: UIViewRepresentable {
    
    @ObservedObject var warData: WarData
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        for location in warData.locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.title
            mapView.addAnnotation(annotation)
        }
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: 49.25, longitude: 31.51)
        let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 5000000, longitudinalMeters: 5000000)
        mapView.setRegion(region, animated: false)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "location")
            annotationView.canShowCallout = true
            return annotationView
        }
    }
}

class WarData: ObservableObject {
    
    @Published var locations = [Location]()
    
    init() {
        // Replace this with real-time data source
        self.locations = [
            Location(coordinate: CLLocationCoordinate2D(latitude: 49.98, longitude: 36.23), title: "UNSAFE"),
            Location(coordinate: CLLocationCoordinate2D(latitude: 50.45, longitude: 30.52), title: "UNSAFE"),
            Location(coordinate: CLLocationCoordinate2D(latitude: 48.37, longitude: 38.07), title: "UNSAFE"),
            Location(coordinate: CLLocationCoordinate2D(latitude: 49.30, longitude: 38.17), title: "UNSAFE"),
            Location(coordinate: CLLocationCoordinate2D(latitude: 50.37, longitude: 38.07), title: "UNSAFE")
        ]
    }
}

struct Location {
    let coordinate: CLLocationCoordinate2D
    let title: String
}




#Preview {
    Nearby()
}
