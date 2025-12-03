//
//  AddPasswordView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct CreatePasswordView: View {
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress Indicator
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(index <= 3 ? AppColor.accent : AppColor.separator)
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
                                    Image(systemName: "lock.fill")
                                        .font(.title2)
                                        .foregroundColor(AppColor.accent)
                                )
                            
                            VStack(spacing: 12) {
                                Text("Secure your account")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppColor.text)
                                    .multilineTextAlignment(.center)
                                
                                Text("Create a strong password to protect your personal information and conversations within our safe community.")
                                    .font(.body)
                                    .foregroundColor(AppColor.textSecondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                            }
                        }
                        .padding(.top, 40)
                        
                        // Form Section
                        VStack(spacing: 24) {
                            VStack(spacing: 16) {
                                SecureField("Create password", text: $password)
                                    .textContentType(.newPassword)
                                    .modifier(TextFieldModifiers())
                                
                                SecureField("Confirm password", text: $confirmPassword)
                                    .textContentType(.newPassword)
                                    .modifier(TextFieldModifiers())
                            }
                            
                            // Password Requirements
                            VStack(alignment: .leading, spacing: 8) {
                                PasswordRequirement(
                                    text: "At least 8 characters",
                                    isMet: password.count >= 8
                                )
                                PasswordRequirement(
                                    text: "Passwords match",
                                    isMet: !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            
                            NavigationLink {
                                CompleteSignUpView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                Text("Create Account")
                                    .modifier(ButtonModifiers())
                            }
                            .disabled(!isPasswordValid)
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
    
    private var isPasswordValid: Bool {
        password.count >= 8 && password == confirmPassword && !confirmPassword.isEmpty
    }
}

struct PasswordRequirement: View {
    let text: String
    let isMet: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isMet ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isMet ? AppColor.success : AppColor.textSecondary)
                .font(.caption)
            
            Text(text)
                .font(.caption)
                .foregroundColor(isMet ? AppColor.success : AppColor.textSecondary)
        }
    }
}

#Preview {
    CreatePasswordView()
}
