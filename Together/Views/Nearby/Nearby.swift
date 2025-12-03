//
//  NearbyView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct Nearby: View {
    
    @ObservedObject private var warData = WarData()
    
    var body: some View {
        ZStack {
            MapView(warData: warData)
                .ignoresSafeArea(.all)
            
            // Safety Legend
            VStack {
                Spacer()
                HStack {
                    SafetyLegend()
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct SafetyLegend: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Safety Levels")
                .font(.headline)
                .padding(.bottom, 4)
            
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 12, height: 12)
                Text("Safe (1-2 users)")
                    .font(.caption)
            }
            
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 12, height: 12)
                Text("Unsafe (3-5 users)")
                    .font(.caption)
            }
            
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                Text("Dangerous (6+ users)")
                    .font(.caption)
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        .shadow(radius: 5)
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
        // Remove existing overlays and annotations
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        // Add location annotations and their matching radius circles
        for location in warData.locations {
            // Add the annotation/pin
            let annotation = SafetyAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.title
            annotation.safetyLevel = location.safetyLevel
            mapView.addAnnotation(annotation)
            
            // Add a circle with the same safety level around each location
            let radius: CLLocationDistance = warData.getRadiusForSafetyLevel(location.safetyLevel)
            let circle = SafetyCircle(center: location.coordinate, radius: radius)
            circle.safetyLevel = location.safetyLevel
            mapView.addOverlay(circle)
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
            guard let safetyAnnotation = annotation as? SafetyAnnotation else { return nil }
            
            let identifier = "SafetyAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            // Set marker color based on safety level
            switch safetyAnnotation.safetyLevel {
            case .safe:
                annotationView?.markerTintColor = .systemGreen
                annotationView?.glyphText = "✓"
            case .unsafe:
                annotationView?.markerTintColor = .systemOrange
                annotationView?.glyphText = "⚠"
            case .dangerous:
                annotationView?.markerTintColor = .systemRed
                annotationView?.glyphText = "⚠"
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let safetyCircle = overlay as? SafetyCircle else {
                return MKOverlayRenderer(overlay: overlay)
            }
            
            let renderer = MKCircleRenderer(circle: safetyCircle)
            
            // Use the safety level directly from the circle
            switch safetyCircle.safetyLevel {
            case .safe:
                renderer.fillColor = UIColor.systemGreen.withAlphaComponent(0.2)
                renderer.strokeColor = UIColor.systemGreen.withAlphaComponent(0.5)
            case .unsafe:
                renderer.fillColor = UIColor.systemOrange.withAlphaComponent(0.2)
                renderer.strokeColor = UIColor.systemOrange.withAlphaComponent(0.5)
            case .dangerous:
                renderer.fillColor = UIColor.systemRed.withAlphaComponent(0.2)
                renderer.strokeColor = UIColor.systemRed.withAlphaComponent(0.5)
            }
            
            renderer.lineWidth = 2
            return renderer
        }
    }
}

// MARK: - Safety Circle
class SafetyCircle: MKCircle {
    var safetyLevel: SafetyLevel = .safe
    
    convenience init(center: CLLocationCoordinate2D, radius: CLLocationDistance) {
        self.init(center: center, radius: radius)
    }
}

// MARK: - Safety Level Enum
enum SafetyLevel {
    case safe
    case unsafe
    case dangerous
    
    var displayName: String {
        switch self {
        case .safe: return "SAFE"
        case .unsafe: return "UNSAFE"
        case .dangerous: return "DANGEROUS"
        }
    }
    
    var color: UIColor {
        switch self {
        case .safe: return .systemGreen
        case .unsafe: return .systemOrange
        case .dangerous: return .systemRed
        }
    }
}

// MARK: - Safety Annotation
class SafetyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var safetyLevel: SafetyLevel
    
    init(coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0), 
         title: String? = nil, 
         safetyLevel: SafetyLevel = .safe) {
        self.coordinate = coordinate
        self.title = title
        self.safetyLevel = safetyLevel
        super.init()
    }
}

// MARK: - Safety Zone
struct SafetyZone {
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance // in meters
    let safetyLevel: SafetyLevel
    let userCount: Int // Number of users from this area
}

// MARK: - War Data
class WarData: ObservableObject {
    
    @Published var locations = [Location]()
    @Published var safetyZones = [SafetyZone]()
    
    init() {
        // Sample data - replace with real user location data
        self.locations = [
            Location(coordinate: CLLocationCoordinate2D(latitude: 49.98, longitude: 36.23), 
                    title: "DANGEROUS", safetyLevel: .dangerous),
            Location(coordinate: CLLocationCoordinate2D(latitude: 50.45, longitude: 30.52), 
                    title: "UNSAFE", safetyLevel: .unsafe),
            Location(coordinate: CLLocationCoordinate2D(latitude: 48.37, longitude: 38.07), 
                    title: "DANGEROUS", safetyLevel: .dangerous),
            Location(coordinate: CLLocationCoordinate2D(latitude: 49.30, longitude: 38.17), 
                    title: "SAFE", safetyLevel: .safe),
            Location(coordinate: CLLocationCoordinate2D(latitude: 50.37, longitude: 38.07), 
                    title: "UNSAFE", safetyLevel: .unsafe)
        ]
        
        // Generate safety zones based on user concentrations
        self.safetyZones = generateSafetyZones(from: locations)
    }
    
    // MARK: - Safety Zone Generation
    private func generateSafetyZones(from locations: [Location]) -> [SafetyZone] {
        var zones: [SafetyZone] = []
        
        // Group locations by proximity and calculate safety levels
        let groupedLocations = groupLocationsByProximity(locations)
        
        for group in groupedLocations {
            let centerCoordinate = calculateCenterCoordinate(for: group)
            let userCount = group.count
            let safetyLevel = determineSafetyLevel(userCount: userCount)
            let radius = calculateRadius(for: group, userCount: userCount)
            
            let zone = SafetyZone(
                coordinate: centerCoordinate,
                radius: radius,
                safetyLevel: safetyLevel,
                userCount: userCount
            )
            zones.append(zone)
        }
        
        return zones
    }
    
    private func groupLocationsByProximity(_ locations: [Location]) -> [[Location]] {
        var groups: [[Location]] = []
        var ungroupedLocations = locations
        
        while !ungroupedLocations.isEmpty {
            let currentLocation = ungroupedLocations.removeFirst()
            var currentGroup = [currentLocation]
            
            // Find nearby locations (within 100km)
            ungroupedLocations.removeAll { location in
                let distance = distanceBetween(currentLocation.coordinate, location.coordinate)
                if distance < 100000 { // 100km in meters
                    currentGroup.append(location)
                    return true
                }
                return false
            }
            
            groups.append(currentGroup)
        }
        
        return groups
    }
    
    private func calculateCenterCoordinate(for locations: [Location]) -> CLLocationCoordinate2D {
        let totalLatitude = locations.reduce(0) { $0 + $1.coordinate.latitude }
        let totalLongitude = locations.reduce(0) { $0 + $1.coordinate.longitude }
        let count = Double(locations.count)
        
        return CLLocationCoordinate2D(
            latitude: totalLatitude / count,
            longitude: totalLongitude / count
        )
    }
    
    private func determineSafetyLevel(userCount: Int) -> SafetyLevel {
        switch userCount {
        case 1...2:
            return .safe
        case 3...5:
            return .unsafe
        default:
            return .dangerous
        }
    }
    
    private func calculateRadius(for locations: [Location], userCount: Int) -> CLLocationDistance {
        // Base radius increases with user count
        let baseRadius: CLLocationDistance = 50000 // 50km base
        let multiplier = Double(userCount) * 0.3
        return baseRadius + (baseRadius * multiplier)
    }
    
    private func distanceBetween(_ coord1: CLLocationCoordinate2D, _ coord2: CLLocationCoordinate2D) -> CLLocationDistance {
        let location1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
        let location2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
        return location1.distance(from: location2)
    }
    
    // MARK: - Public Methods for Real Implementation
    func updateUserLocations(_ userLocations: [UserLocation]) {
        // Convert user locations to safety locations
        let newLocations = userLocations.map { userLocation in
            Location(
                coordinate: userLocation.coordinate,
                title: "User from \(userLocation.originCountry ?? "Unknown")",
                safetyLevel: .safe // Will be recalculated
            )
        }
        
        self.locations = newLocations
        self.safetyZones = generateSafetyZones(from: newLocations)
    }
    
    // MARK: - Helper Methods
    func getRadiusForSafetyLevel(_ safetyLevel: SafetyLevel) -> CLLocationDistance {
        switch safetyLevel {
        case .safe:
            return 30000 // 30km for safe areas
        case .unsafe:
            return 50000 // 50km for unsafe areas
        case .dangerous:
            return 80000 // 80km for dangerous areas
        }
    }
}

struct Location {
    let coordinate: CLLocationCoordinate2D
    let title: String
    let safetyLevel: SafetyLevel
}

// MARK: - User Location Model (for integration with your user system)
struct UserLocation {
    let coordinate: CLLocationCoordinate2D
    let originCountry: String?
    let userId: String
    // Add other relevant user properties
}




#Preview {
    Nearby()
}
