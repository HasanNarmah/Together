//
//  PostView.swift
//  Together
//
//  Created by Hasan Narmah on 08/03/2024.
//

import SwiftUI
import MapKit

struct Post {
    let id = UUID()
    let category: String
    let username: String
    let userLocation: String? // This should come from CreatePostView's selectedLocationAddress
    let timeAgo: String
    let title: String
    let content: String?
    let imageURL: String?
    let comments: Int
}

struct PostCell: View {
    let post: Post
    
    init(post: Post = Post.samplePosts[0]) {
        self.post = post
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header with category, user, location and time
            HStack(spacing: 8) {
                // Category icon placeholder
                Circle()
                    .fill(Color.orange)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Text("c")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    )
                
                Text(post.category)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                // Show location only if available
                if let location = post.userLocation {
                    Text("•")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(location)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Text(post.username)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("•")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                Text(post.timeAgo)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button {
                    // More options
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // Post title
            Text(post.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.top, 8)
            
            // Post content text (if available)
            if let content = post.content {
                Text(content)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(.top, 4)
            }
            
            // Post image (if available)
            if post.imageURL != nil {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.title2)
                            .foregroundColor(.gray)
                    )
                    .padding(.horizontal)
                    .padding(.top, 8)
            }
            
            // Action bar with directions, comments, share
            HStack(spacing: 0) {
                // Directions button (only show if location is available)
                if post.userLocation != nil {
                    Button {
                        openDirectionsWithMapKit()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "location.north.line")
                                .font(.system(size: 16))
                            Text("Directions")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
                
                // Comments button
                Button {
                    // Handle comments
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "message")
                            .font(.system(size: 16))
                        Text("\(post.comments)")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Share button
                Button {
                    // Handle share
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Save button (replacing award)
                Button {
                    // Handle save
                } label: {
                    Image(systemName: "bookmark")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .background(Color(UIColor.systemBackground))
    }
    
    private func openDirections() {
        guard let location = post.userLocation else { return }
        
        // URL encode the location address
        let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // Try Apple Maps with live directions first
        if let appleMapURL = URL(string: "http://maps.apple.com/?daddr=\(encodedLocation)&dirflg=d"),
           UIApplication.shared.canOpenURL(appleMapURL) {
            UIApplication.shared.open(appleMapURL)
        }
        // Fallback to Google Maps with live directions
        else if let googleMapURL = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(encodedLocation)&travelmode=driving"),
                UIApplication.shared.canOpenURL(googleMapURL) {
            UIApplication.shared.open(googleMapURL)
        }
        // Final fallback to basic Apple Maps
        else if let basicMapURL = URL(string: "http://maps.apple.com/?q=\(encodedLocation)") {
            UIApplication.shared.open(basicMapURL)
        }
    }
    
    // Alternative method using MapKit for more advanced integration
    private func openDirectionsWithMapKit() {
        guard let locationString = post.userLocation else { return }
        
        // Geocode the address to get coordinates
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationString) { placemarks, error in
            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                // Fallback to URL scheme if geocoding fails
                self.openDirections()
                return
            }
            
            // Create MKMapItem for the destination
            let destinationCoordinate = location.coordinate
            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            destinationMapItem.name = locationString
            
            // Configure directions
            let launchOptions = [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                MKLaunchOptionsShowsTrafficKey: true
            ]
            
            // Open Maps with live directions
            destinationMapItem.openInMaps(launchOptions: launchOptions)
        }
    }
}

// Sample data for preview
extension Post {
    static let samplePosts = [
        Post(
            category: "General",
            username: "techguru2024",
            userLocation: "San Francisco, CA",
            timeAgo: "3h",
            title: "Apple announces new breakthrough in battery technology that could revolutionize electric vehicles",
            content: "This could be a game changer for the entire EV industry. The new solid-state batteries promise 3x the energy density of current lithium-ion batteries.",
            imageURL: "sample",
            comments: 342
        ),
        Post(
            category: "Tech",
            username: "curious_cat",
            userLocation: "London, UK",
            timeAgo: "5h",
            title: "What's the most mind-blowing fact you learned this week?",
            content: nil,
            imageURL: nil,
            comments: 486
        ),
        Post(
            category: "Art",
            username: "codewarrior",
            userLocation: nil,
            timeAgo: "7h",
            title: "Why I'm switching from React to SwiftUI for my next project",
            content: "After years of web development, I decided to dive into iOS development. Here's what I learned in my first month with SwiftUI...",
            imageURL: nil,
            comments: 89
        ),
        Post(
            category: "Sports",
            username: "naturelover",
            userLocation: "Zurich, Switzerland",
            timeAgo: "2h",
            title: "Sunrise over the Swiss Alps [OC] [4032x3024]",
            content: nil,
            imageURL: "sample",
            comments: 123
        ),
        Post(
            category: "General",
            username: "randomobserver",
            userLocation: "New York, NY",
            timeAgo: "1h",
            title: "My coffee mug has a hidden message that only appears when it's hot",
            content: nil,
            imageURL: "sample",
            comments: 234
        )
    ]
}

#Preview {
    ScrollView {
        LazyVStack(spacing: 1) {
            ForEach(Post.samplePosts, id: \.id) { post in
                PostCell(post: post)
                    .background(Color(UIColor.systemBackground))
                Divider()
                    .background(Color(UIColor.separator))
            }
        }
    }
    .background(Color(UIColor.systemGray6))
}
