//
//  CreatePostView.swift
//  Together
//
//  Created by Hasan Narmah on 23/04/2024.
//

import SwiftUI

struct CreatePostView: View {
    @State private var title = ""
    @State private var content = ""
    @State private var selectedCategory = "General"
    @State private var isPublic = true
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
                    Form {
                        Section(header: Text("Post Details")) {
                            TextField("Post Title", text: $title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        }
                        
                        Section(header: Text("Content")) {
                            TextEditor(text: $content)
                                .frame(minHeight: 150)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                        
                        Section(header: Text("Privacy Settings")) {
                            Toggle("Make Public", isOn: $isPublic)
                                .toggleStyle(SwitchToggleStyle())
                        }
                        
                        Section {
                            HStack {
                                Spacer()
                                Button("Create Post") {
                                    createPost()
                                }
                                .buttonStyle(.borderedProminent)
                                .disabled(title.isEmpty || content.isEmpty)
                                Spacer()
                            }
                        }
                                   }
                                   .navigationTitle("Create Post")
                                   .navigationBarTitleDisplayMode(.inline)
                                   .toolbar {
                                       ToolbarItem(placement: .navigationBarLeading) {
                                           Button("Cancel") {
                                               dismiss()
                                           }
                                       }
                                   }
                                   .alert("Post Status", isPresented: $showingAlert) {
                                       Button("OK") {
                                           if alertMessage.contains("successfully") {
                                               dismiss()
                                           }
                                       }
                                   } message: {
                                       Text(alertMessage)
                                   }
                               }
                           }
                           
                           private func createPost() {
                               // Validate input
                               guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                                     !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                                   alertMessage = "Please fill in both title and content."
                                   showingAlert = true
                                   return
                               }
                               
                               // Create post object
                               let post = Post(
                                   id: UUID(),
                                   title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                                   content: content.trimmingCharacters(in: .whitespacesAndNewlines),
                                   category: selectedCategory,
                                   isPublic: isPublic,
                                   createdAt: Date()
                               )
                               
                               // Here you would typically save to your data store
                               // For example: PostManager.shared.createPost(post)
                               // or send to your API endpoint
                               
                               // Simulate API call
                               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                   alertMessage = "Post created successfully!"
                                   showingAlert = true
                                   
                                   // Clear form
                                   title = ""
                                   content = ""
                                   selectedCategory = "General"
                                   isPublic = true
                               }
                           }
                       }

                       // Post model
                       struct Post: Identifiable, Codable {
                           let id: UUID
                           let title: String
                           let content: String
                           let category: String
                           let isPublic: Bool
                           let createdAt: Date
                       }

#Preview {
    CreatePostView()
}
