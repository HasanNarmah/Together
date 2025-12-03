//
//  CreatePostView.swift
//  Together
//
//  Created by Hasan Narmah on 23/04/2024.
//

import SwiftUI
import PhotosUI
import CoreLocationUI
import CoreLocation

struct CreatePostView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var postText: String = ""
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var selectedPhotoImages: [UIImage] = []
    @State private var selectedVideo: URL?
    @State private var showVideoPicker = false
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var selectedLocationAddress: String?
    @State private var showLocationPicker = false
    @State private var selectedCommunity: String = ""
    @State private var showCategorySheet: Bool = false
    
    @State private var categories: [String] = ["General", "Tech", "Art", "Sports"] // Replace with your actual community list or load dynamically
    @State private var newCategoryName: String = ""
    private let defaultCategories: Set<String> = ["General", "Tech", "Art", "Sports"]
    
    @State private var isVisible = false
    
    private var canPost: Bool {
        !postText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        || !selectedPhotoImages.isEmpty
        || selectedVideo != nil
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Fixed content area (no scrolling)
                VStack(spacing: 0) {
                    // Composer header: Avatar + Text
                    HStack(alignment: .top, spacing: 12) {
                        // Placeholder avatar (replace with real avatar)
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .overlay(Text("H").font(.headline).foregroundColor(.white))

                        ZStack(alignment: .topLeading) {
                            if postText.isEmpty {
                                Text("What’s happening?")
                                    .foregroundColor(.secondary)
                                    .padding(.top, 8)
                            }
                            TextEditor(text: $postText)
                                .scrollContentBackground(.hidden)
                                .scrollDisabled(true)
                                .frame(height: 120)
                                .padding(.top, -4)
                        }
                    }
                    .padding()

                    // Selected media previews - horizontal scroll only
                    if !selectedPhotoImages.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(selectedPhotoImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                        }
                        .frame(height: 110)
                    }

                    if let videoURL = selectedVideo {
                        HStack(spacing: 8) {
                            Image(systemName: "video.fill")
                                .foregroundStyle(.secondary)
                            Text(videoURL.lastPathComponent)
                                .lineLimit(1)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }

                    if let location = selectedLocation {
                        HStack(spacing: 8) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundStyle(.secondary)
                            Text(selectedLocationAddress ?? String(format: "%.6f, %.6f", location.latitude, location.longitude))
                                .foregroundStyle(.secondary)
                            Spacer()
                            Button {
                                selectedLocation = nil
                                selectedLocationAddress = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }

                    Divider()

                    // Category row (like Twitter's Audience)
                    Button {
                        showCategorySheet = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "person.2.fill")
                                .foregroundStyle(.secondary)
                            Text(selectedCommunity.isEmpty ? "Choose category" : selectedCommunity)
                                .foregroundStyle(selectedCommunity.isEmpty ? .secondary : .primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                    }
                    .sheet(isPresented: $showCategorySheet) {
                        NavigationStack {
                            List {
                                // Add Category Section
                                Section("Add Category") {
                                    HStack {
                                        TextField("New category name", text: $newCategoryName)
                                            .textInputAutocapitalization(.words)
                                            .disableAutocorrection(true)
                                        Button("Add") {
                                            let trimmed = newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines)
                                            guard !trimmed.isEmpty else { return }
                                            if !categories.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) {
                                                categories.append(trimmed)
                                            }
                                            selectedCommunity = trimmed
                                            newCategoryName = ""
                                            showCategorySheet = false
                                        }
                                        .disabled(newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                                    }
                                }

                                // Existing Categories Section
                                Section("Categories") {
                                    ForEach(categories, id: \.self) { (community: String) in
                                        HStack {
                                            Button {
                                                selectedCommunity = community
                                                showCategorySheet = false
                                            } label: {
                                                HStack {
                                                    Text(community)
                                                    Spacer()
                                                    if selectedCommunity == community {
                                                        Image(systemName: "checkmark")
                                                            .foregroundStyle(.tint)
                                                    }
                                                }
                                            }
                                        }
                                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                            Button(role: .destructive) {
                                                if let idx = categories.firstIndex(of: community) {
                                                    let wasSelected = (selectedCommunity == community)
                                                    categories.remove(at: idx)
                                                    if wasSelected { selectedCommunity = "" }
                                                }
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                    }
                                }
                            }
                            .navigationTitle("Select Category")
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    Button("Done") { showCategorySheet = false }
                                }
                            }
                        }
                    }

                    Divider()

                    // Composer toolbar (attachments)
                    HStack(spacing: 18) {
                        PhotosPicker(
                            selection: $selectedPhotos,
                            maxSelectionCount: 5,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            Image(systemName: "photo")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .onChange(of: selectedPhotos) { _, newValue in
                            Task {
                                selectedPhotoImages = []
                                for item in newValue {
                                    if let data = try? await item.loadTransferable(type: Data.self),
                                       let image = UIImage(data: data) {
                                        selectedPhotoImages.append(image)
                                    }
                                }
                            }
                        }

                        Button {
                            showVideoPicker = true
                        } label: {
                            Image(systemName: "video")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .sheet(isPresented: $showVideoPicker) {
                            VideoPicker(selectedVideo: $selectedVideo)
                        }

                        Button {
                            showLocationPicker = true
                        } label: {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .sheet(isPresented: $showLocationPicker) {
                            LocationPicker(
                                selectedLocation: $selectedLocation,
                                selectedLocationAddress: $selectedLocationAddress
                            )
                        }

                        Spacer()

                        if !postText.isEmpty {
                            Text("\(postText.count)")
                                .foregroundStyle(.secondary)
                                .font(.footnote)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .background(Color(UIColor.systemBackground))
                
                Spacer()
                
                // Post Button centered in the middle of the screen
                VStack {
                    Spacer()
                    Button(action: submitPost) {
                        Text("Post")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 16)
                            .background(canPost ? Color.accentColor : Color.gray.opacity(0.3))
                            .foregroundColor(canPost ? .white : .primary.opacity(0.5))
                            .clipShape(Capsule())
                    }
                    .disabled(!canPost)
                    Spacer()
                }
            }
            .navigationTitle("Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .offset(y: isVisible ? 0 : UIScreen.main.bounds.height)
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.easeOut(duration: 0.5)) {
                    isVisible = true
                }
            }
        }
    }
    
    func submitPost() {
        // Handle post submission logic here
        print("Post text: \(postText)")
        print("Selected images: \(selectedPhotoImages.count)")
        print("Selected video: \(String(describing: selectedVideo))")
        print("Selected location: \(String(describing: selectedLocation))")
        print("Selected location address: \(String(describing: selectedLocationAddress))")
        print("Selected community: \(selectedCommunity)")
    }
}

// Video picker implementation
struct VideoPicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedVideo: URL?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.mediaTypes = ["public.movie"]
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: VideoPicker
        
        init(_ parent: VideoPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let url = info[.mediaURL] as? URL {
                parent.selectedVideo = url
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

// Location picker that gets current device location
struct LocationPicker: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedLocation: CLLocationCoordinate2D?
    @Binding var selectedLocationAddress: String?
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if locationManager.isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                        Text("Getting your location...")
                            .foregroundStyle(.secondary)
                    }
                } else if let location = locationManager.currentLocation {
                    VStack(spacing: 12) {
                        Image(systemName: "location.fill")
                            .font(.title)
                            .foregroundStyle(.green)
                        
                        Text("Current Location")
                            .font(.headline)
                        
                        VStack(spacing: 4) {
                            Text("Latitude: \(location.latitude, specifier: "%.6f")")
                            Text("Longitude: \(location.longitude, specifier: "%.6f")")
                        }
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        
                        if let address = locationManager.currentAddress {
                            Text(address)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        Button("Use This Location") {
                            selectedLocation = location
                            selectedLocationAddress = locationManager.currentAddress
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else if locationManager.authorizationStatus == .denied {
                    VStack(spacing: 12) {
                        Image(systemName: "location.slash")
                            .font(.title)
                            .foregroundStyle(.red)
                        
                        Text("Location Access Denied")
                            .font(.headline)
                        
                        Text("Please enable location access in Settings to use this feature.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        Button("Open Settings") {
                            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(settingsURL)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else if locationManager.authorizationStatus == .notDetermined {
                    VStack(spacing: 12) {
                        Image(systemName: "location")
                            .font(.title)
                            .foregroundStyle(.blue)
                        
                        Text("Location Permission")
                            .font(.headline)
                        
                        Text("We need location permission to add your current location to posts.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        Button("Allow Location Access") {
                            locationManager.requestLocationPermission()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.title)
                            .foregroundStyle(.orange)
                        
                        Text("Unable to Get Location")
                            .font(.headline)
                        
                        Text("There was a problem getting your location. Please try again.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        Button("Try Again") {
                            locationManager.getCurrentLocation()
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if locationManager.authorizationStatus == .authorizedWhenInUse || 
                   locationManager.authorizationStatus == .authorizedAlways {
                    locationManager.getCurrentLocation()
                }
            }
        }
    }
}

// Location manager to handle device location
class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var currentAddress: String?
    @Published var isLoading = false
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        authorizationStatus = locationManager.authorizationStatus
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() {
        guard authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways else {
            return
        }
        
        isLoading = true
        locationManager.requestLocation()
    }
    
    private func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                if let placemark = placemarks?.first {
                    var addressComponents: [String] = []
                    
                    if let name = placemark.name {
                        addressComponents.append(name)
                    }
                    if let locality = placemark.locality {
                        addressComponents.append(locality)
                    }
                    if let country = placemark.country {
                        addressComponents.append(country)
                    }
                    
                    self?.currentAddress = addressComponents.joined(separator: ", ")
                }
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
            
            if self.authorizationStatus == .authorizedWhenInUse || 
               self.authorizationStatus == .authorizedAlways {
                self.getCurrentLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.isLoading = false
            
            if let location = locations.first {
                self.currentLocation = location.coordinate
                self.reverseGeocode(location: location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            print("Location error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CreatePostView()
}
