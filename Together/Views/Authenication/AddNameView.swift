//
//  AddNameView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct AddNameView: View {
    @State private var name = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress Indicator
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(index == 0 ? AppColor.accent : AppColor.separator)
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
                                    Image(systemName: "person.fill")
                                        .font(.title2)
                                        .foregroundColor(AppColor.accent)
                                )
                            
                            VStack(spacing: 12) {
                                Text("What should we call you?")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppColor.text)
                                    .multilineTextAlignment(.center)
                                
                                Text("Your name helps others connect with you in a more personal way. This creates trust in our healing community.")
                                    .font(.body)
                                    .foregroundColor(AppColor.textSecondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                            }
                        }
                        .padding(.top, 40)
                        
                        // Form Section
                        VStack(spacing: 24) {
                            TextField("Enter your name", text: $name)
                                .textContentType(.name)
                                .modifier(TextFieldModifiers())
                            
                            NavigationLink {
                                AddLocationView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                Text("Continue")
                                    .modifier(ButtonModifiers())
                            }
                            .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
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
    AddNameView()
}
