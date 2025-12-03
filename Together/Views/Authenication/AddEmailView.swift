//
//  AddEmailView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct AddEmailView: View {
    @State private var email = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress Indicator
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(index <= 2 ? AppColor.accent : AppColor.separator)
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
                                    Image(systemName: "envelope.fill")
                                        .font(.title2)
                                        .foregroundColor(AppColor.accent)
                                )
                            
                            VStack(spacing: 12) {
                                Text("What's your email?")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppColor.text)
                                    .multilineTextAlignment(.center)
                                
                                Text("Your email is used to sign into your account and receive important updates about your connections and community activities.")
                                    .font(.body)
                                    .foregroundColor(AppColor.textSecondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                                
                                Text("We respect your privacy and will never share your email.")
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
                            TextField("Enter your email", text: $email)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .modifier(TextFieldModifiers())
                            
                            NavigationLink {
                                CreatePasswordView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                Text("Continue")
                                    .modifier(ButtonModifiers())
                            }
                            .disabled(!isValidEmail(email))
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
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}


#Preview {
    AddEmailView()
}
