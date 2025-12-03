//
//  AddLocationView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct AddLocationView: View {
    @State private var location = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress Indicator
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(index <= 1 ? AppColor.accent : AppColor.separator)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Header Section
                        VStack(spacing: 20) {
                            // Icon
                            Circle()
                                .fill(AppColor.accent.opacity(0.1))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "location.fill")
                                        .font(.title2)
                                        .foregroundColor(AppColor.accent)
                                )
                            
                            VStack(spacing: 12) {
                                Text("Where are you located?")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppColor.text)
                                    .multilineTextAlignment(.center)
                                
                                Text("Sharing your general location helps us connect you with nearby communities and support networks that understand your local context.")
                                    .font(.body)
                                    .foregroundColor(AppColor.textSecondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                                
                                Text("Your privacy is important to us - only general area information is shared.")
                                    .font(.caption)
                                    .foregroundColor(AppColor.textSecondary)
                                    .italic()
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 32)
                            }
                        }
                        .padding(.top, 40)
                        
                        // Form Section
                        VStack(spacing: 24) {
                            TextField("City, Country", text: $location)
                                .textContentType(.addressCity)
                                .modifier(TextFieldModifiers())
                            
                            NavigationLink {
                                AddEmailView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                Text("Continue")
                                    .modifier(ButtonModifiers())
                            }
                            .disabled(location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .background(AppColor.background)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.body)
                            Text("Back")
                                .font(.body)
                        }
                        .foregroundColor(AppColor.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    AddLocationView()
}
