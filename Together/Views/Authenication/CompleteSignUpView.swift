//
//  CompleteSignUpView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct CompleteSignUpView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    Spacer(minLength: 60)
                    
                    // Success Animation/Icon
                    VStack(spacing: 20) {
                        Circle()
                            .fill(AppColor.success.opacity(0.1))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(AppColor.success)
                            )
                        
                        Text("🎉")
                            .font(.system(size: 50))
                    }
                    
                    // Welcome Message
                    VStack(spacing: 16) {
                        Text("Welcome to Together!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(AppColor.text)
                            .multilineTextAlignment(.center)
                        
                        Text("You're now part of a community dedicated to healing, understanding, and rebuilding connections.")
                            .font(.body)
                            .foregroundColor(AppColor.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    
                    // Mission Statement
                    VStack(spacing: 12) {
                        Rectangle()
                            .fill(AppColor.accent.opacity(0.1))
                            .frame(height: 1)
                            .padding(.horizontal, 40)
                        
                        Text("\"Empowering Connections, Rebuilding Lives Together\"")
                            .font(.headline)
                            .foregroundColor(AppColor.accent)
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        
                        Rectangle()
                            .fill(AppColor.accent.opacity(0.1))
                            .frame(height: 1)
                            .padding(.horizontal, 40)
                    }
                    
                    // Features Preview
                    VStack(spacing: 20) {
                        Text("What you can do now:")
                            .font(.headline)
                            .foregroundColor(AppColor.text)
                        
                        VStack(spacing: 16) {
                            FeatureItem(
                                icon: "person.2.fill",
                                title: "Connect with Others",
                                description: "Find people who understand your journey"
                            )
                            
                            FeatureItem(
                                icon: "heart.fill",
                                title: "Join Support Communities",
                                description: "Access local and global support networks"
                            )
                            
                            FeatureItem(
                                icon: "bubble.left.and.bubble.right.fill",
                                title: "Safe Conversations",
                                description: "Engage in meaningful, respectful dialogue"
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Action Button
                    VStack(spacing: 16) {
                        NavigationLink {
                            MainView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Start Your Journey")
                                .modifier(ButtonModifiers())
                        }
                        
                        Text("Ready to rebuild connections and find hope")
                            .font(.caption)
                            .foregroundColor(AppColor.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 20)
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

struct FeatureItem: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(AppColor.accent.opacity(0.1))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundColor(AppColor.accent)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(AppColor.text)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(AppColor.textSecondary)
            }
            
            Spacer()
        }
    }
}

#Preview {
    CompleteSignUpView()
}
