//
//  CreatePostView.swift
//  Together
//
//  Created by Hasan Narmah on 23/04/2024.
//

import SwiftUI
import PhotosUI
import CoreLocationUI

struct CreatePostView: View {
    @State private var postText: String = ""
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var selectedPhotoImages: [UIImage] = []
    @State private var selectedVideo: URL?
    @State private var showVideoPicker = false
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var showLocationPicker = false
    @State private var selectedCommunity: String = ""
    
    let communities = ["General", "Tech", "Art", "Sports"] // Replace with your actual community list
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Post text input
                    TextEditor(text: $postText)
                        .frame(minHeight: 120)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                        .padding(.horizontal)
                    
                    // Attachments section
                    HStack {
                        // Photo picker
                        PhotosPicker(
                            selection: $selectedPhotos,
                            maxSelectionCount: 5,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Image(systemName: "photo.on.rectangle")
                                    .font(.title)
                                    .padding()
                            }
                            .onChange(of: selectedPhotos) { items in
                                Task {
                                    selectedPhotoImages = []
                                    for item in items {
                                        if let data = try? await item.loadTransferable(type: Data.self),
                                           let image = UIImage(data: data) {
                                            selectedPhotoImages.append(image)
                                        }
                                    }
                                }
                            }
                        
                        // Video picker
                        Button {
                            showVideoPicker = true
                        } label: {
                            Image(systemName: "video")
                                .font(.title)
                                .padding()
                        }
                        .sheet(isPresented: $showVideoPicker) {
                            VideoPicker(selectedVideo: $selectedVideo)
                        }
                        
                        // Location picker
                        Button {
                            showLocationPicker = true
                        } label: {
                            Image(systemName: "location")
                                .font(.title)
                                .padding()
                        }
                        .sheet(isPresented: $showLocationPicker) {
                            LocationPicker(selectedLocation: $selectedLocation)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Preview selected images
                    if !selectedPhotoImages.isEmpty {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(selectedPhotoImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Preview selected video
                    if let videoURL = selectedVideo {
                        Text("Selected Video: \(videoURL.lastPathComponent)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    
                    // Preview selected location
                    if let location = selectedLocation {
                        Text("Selected Location: \(location.latitude), \(location.longitude)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    
                    // Community picker
                    Picker("Categories", selection: $selectedCommunity) {
                        ForEach(communities, id: \.self) { community in
                            Text(community).tag(community)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                    
                    // Submit button
                    Button(action: submitPost) {
                        Text("Post")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
                .navigationTitle("Create Post")
            }
        }
    }
    
    func submitPost() {
        // Handle post submission logic here
        print("Post text: \(postText)")
        print("Selected images: \(selectedPhotoImages.count)")
        print("Selected video: \(String(describing: selectedVideo))")
        print("Selected location: \(String(describing: selectedLocation))")
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

// Location picker stub (replace with your own logic or integration)
struct LocationPicker: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedLocation: CLLocationCoordinate2D?
    
    var body: some View {
        VStack {
            Text("Location Picker Stub")
            Button("Select Example Location") {
                // Example: Set a fixed location
                selectedLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
                dismiss()
            }
            Button("Cancel") {
                dismiss()
            }
        }
    }
}

#Preview {
    CreatePostView()
}

